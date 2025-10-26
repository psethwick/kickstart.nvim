-- Insert Jira ticket ID using fuzzy picker
-- Usage: Call this function from normal or insert mode
-- :lua insert_jira_ticket()

local function insert_jira_ticket()
  -- Command to fetch Jira tickets (using CSV format for easier parsing)
  local jira_cmd = "acli jira workitem search --jql 'assignee = currentUser()' --csv"

  -- Execute the command and capture output
  local handle = io.popen(jira_cmd .. ' 2>&1')
  if not handle then
    vim.notify('Failed to execute Jira command', vim.log.levels.ERROR)
    return
  end

  local output = handle:read '*a'
  local success = handle:close()

  if not success or output == '' then
    vim.notify('No Jira tickets found or command failed', vim.log.levels.WARN)
    return
  end

  -- Parse CSV output into a table of tickets
  local tickets = {}
  local headers = {}
  local first_line = true

  for line in output:gmatch '[^\r\n]+' do
    if line:match '%S' then
      -- Simple CSV parser (handles basic cases)
      local fields = {}
      for field in line:gmatch '([^,]+)' do
        table.insert(fields, field:match '^%s*(.-)%s*$') -- trim whitespace
      end

      if first_line then
        -- Store header positions
        headers = fields
        for i, header in ipairs(headers) do
          headers[header:lower()] = i
        end
        first_line = false
      else
        -- Parse data row
        local key_idx = headers['key'] or 2
        local status_idx = headers['status'] or 5
        local summary_idx = headers['summary'] or 6

        local ticket_id = fields[key_idx]
        local status = fields[status_idx] or ''
        local summary = fields[summary_idx] or ''

        -- Validate ticket ID format (ABC-123)
        if ticket_id and ticket_id:match '^[A-Z]+%-[0-9]+$' then
          table.insert(tickets, {
            id = ticket_id,
            display = string.format('%s [%s] %s', ticket_id, status, summary),
          })
        end
      end
    end
  end

  if #tickets == 0 then
    vim.notify('No valid Jira tickets found', vim.log.levels.WARN)
    return
  end

  -- Use vim.ui.select for fuzzy picking
  vim.ui.select(tickets, {
    prompt = 'Select Jira ticket:',
    format_item = function(item)
      return item.display
    end,
  }, function(choice)
    if choice then
      -- Insert the ticket ID at cursor position
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      local line = vim.api.nvim_get_current_line()

      -- Insert ticket ID with a space before it if not at start
      local prefix = col > 0 and ' ' or ''
      local new_line = line:sub(1, col) .. prefix .. choice.id .. line:sub(col + 1)

      vim.api.nvim_set_current_line(new_line)

      -- Move cursor after inserted text
      vim.api.nvim_win_set_cursor(0, { row, col + #prefix + #choice.id })
    end
  end)
end

-- Create a command for easy access
vim.api.nvim_create_user_command('JiraTicket', insert_jira_ticket, {})

-- Optional: Set up a keybinding
vim.keymap.set({ 'n', 'i' }, '<leader>jt', insert_jira_ticket, { desc = 'Insert Jira ticket' })

return {
  insert_jira_ticket = insert_jira_ticket,
}
