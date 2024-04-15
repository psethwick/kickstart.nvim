return {
  'stevearc/overseer.nvim',
  {
    lazy = false,
    'stevearc/oil.nvim',
    opts = {},
    keys = {
      { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
    },
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',

      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = true,
  },
  {
    'christoomey/vim-tmux-navigator',
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  {
    'vim-test/vim-test',
    keys = {
      { '<leader>tn', ':TestNearest<CR>', desc = 'Test: Nearest' },
      { '<leader>tf', ':TestFile<CR>', desc = 'Test: File' },
      { '<leader>ts', ':TestSuite<CR>', desc = 'Test: Suite' },
      { '<leader>tl', ':TestLast<CR>', desc = 'Test: Last' },
      { '<leader>tv', ':TestVisit<CR>', desc = 'Test: Visit' },
    },
  },
  {
    'anekos/hledger-vim',
    lazy = false,
    config = function()
      --   vim.api.buf
      vim.cmd [[
        autocmd FileType ledger setlocal omnifunc=hledger#complete#omnifunc
      ]]
    end,
  },
}
