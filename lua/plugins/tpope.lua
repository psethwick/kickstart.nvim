return {
  'tpope/vim-characterize',
  'tpope/vim-sleuth',
  'tpope/vim-eunuch',
  {
    'tpope/vim-dispatch',
    config = function()
      local dispatch_commands = {
        rust = 'cargo clippy',
      }

      for filetype, compile_command in pairs(dispatch_commands) do
        vim.api.nvim_create_autocmd('FileType', {
          pattern = filetype,
          callback = function()
            vim.b.dispatch = compile_command
          end,
          desc = 'Set dispatch command for ' .. filetype .. ' files',
        })
      end

      vim.keymap.set('n', '<leader>md', ':Dispatch<CR>', { desc = 'Run dispatch command' })
    end,
  },
}
