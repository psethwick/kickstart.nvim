return {
  'tpope/vim-characterize',
  'tpope/vim-sleuth',
  'tpope/vim-eunuch',
  {
    'tpope/vim-dispatch',
    config = function()
      local commands = {
        rust = 'cargo clippy',
        cs = 'dotnet build',
      }

      for filetype, compile in pairs(commands) do
        vim.api.nvim_create_autocmd('FileType', {
          pattern = filetype,
          callback = function()
            vim.b.dispatch = compile
          end,
          desc = 'Set dispatch command for ' .. filetype .. ' files',
        })
      end

      vim.keymap.set('n', '<leader>md', ':Dispatch<CR>', { desc = 'Run dispatch command' })
    end,
  },
}
