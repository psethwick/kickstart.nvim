local function insert_jira_ticket()
  local db_path = '~/.local/share/pstore/pstore.db'
  local query =
    [[ "select w.id, w.state, w.title from work w join person p on p.id = w.assigned_to_id where p.name = 'Seth Rider' and w.state not in ('Delivered','Done','Deployed');" ]]

  local jira_cmd = string.format('sqlite3 %s -csv %s', db_path, query)

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
      local fields = {}
      for field in line:gmatch '([^,]+)' do
        table.insert(fields, field:match '^%s*(.-)%s*$')
      end

      local ticket_id = fields[1]
      local status = fields[2] or ''
      local summary = fields[3] or ''

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

      local new_line = line:sub(1, col) .. choice.id .. line:sub(col + 1)

      vim.api.nvim_set_current_line(new_line)

      vim.api.nvim_win_set_cursor(0, { row, col + #choice.id })
    end
  end)
end

vim.keymap.set('i', '<C-j>', insert_jira_ticket, { desc = 'Insert Jira ticket' })

return {
  insert_jira_ticket = insert_jira_ticket,
}
