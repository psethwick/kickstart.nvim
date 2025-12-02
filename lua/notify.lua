local function system_notify(msg, level, opts)
  opts = opts or {}
  local title = opts.title or 'Neovim'

  local urgency = 'low'
  if level == vim.log.levels.ERROR then
    urgency = 'critical'
  elseif level == vim.log.levels.WARN then
    urgency = 'normal'
  end

  local cmd = string.format('notify-send -u %s %s %s', vim.fn.shellescape(urgency), vim.fn.shellescape(title), vim.fn.shellescape(msg))

  vim.fn.jobstart(cmd, { detach = true })
end

vim.notify = system_notify

print 'System notifications enabled.'
