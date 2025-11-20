local function insert_jira_ticket()
  local jira_cmd = 'sqlite3 ~/.local/share/pstore/pstore.db -csv "select id,state,title from work where remote_id = 1"'

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

  local tickets = {}

  for line in output:gmatch '[^\r\n]+' do
    if line:match '%S' then
      -- Simple CSV parser (handles basic cases)
      local fields = {}
      for field in line:gmatch '([^,]+)' do
        table.insert(fields, field:match '^%s*(.-)%s*$') -- trim whitespace
      end

      local ticket_id = fields[1]
      local status = fields[2] or ''
      local summary = fields[3] or ''

      -- Validate ticket ID format (ABC-123)
      if ticket_id and ticket_id:match '^[A-Z]+%-[0-9]+$' then
        table.insert(tickets, {
          id = ticket_id,
          display = string.format('%s [%s] %s', ticket_id, status, summary),
        })
      end
    end
  end

  if #tickets == 0 then
    vim.notify('No valid Jira tickets found', vim.log.levels.WARN)
    return
  end

  vim.ui.select(tickets, {
    prompt = 'Select Jira ticket:',
    format_item = function(item)
      return item.display
    end,
  }, function(choice)
    if choice then
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      local line = vim.api.nvim_get_current_line()

      local prefix = col > 0 and ' ' or ''
      local new_line = line:sub(1, col) .. prefix .. choice.id .. line:sub(col + 1)

      vim.api.nvim_set_current_line(new_line)

      vim.api.nvim_win_set_cursor(0, { row, col + #prefix + #choice.id })
    end
  end)
end

vim.keymap.set('i', '<C-j>', insert_jira_ticket, { desc = 'Insert Jira ticket' })

return {
  insert_jira_ticket = insert_jira_ticket,
}
