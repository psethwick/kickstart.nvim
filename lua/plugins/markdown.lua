return {
  'toppair/peek.nvim',
  event = { 'VeryLazy' },
  build = 'deno task --quiet build:fast',
  config = function()
    require('peek').setup {
      app = 'browser',
      theme = 'light',
    }
    vim.keymap.set('n', '<leader>p', function()
      if require('peek').is_open() then
        require('peek').close()
      else
        require('peek').open()
      end
    end, { desc = 'Toggle Peek' })
  end,
}
