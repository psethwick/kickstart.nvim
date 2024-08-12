vim.cmd [[
  autocmd BufEnter *.slint :setlocal filetype=slint
]]

return {
  'wuelnerdotexe/vim-astro',
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
  'stevearc/overseer.nvim',
  {
    'stevearc/oil.nvim',
    lazy = false,
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
