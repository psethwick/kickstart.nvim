return {
  {
    'milanglacier/yarepl.nvim',
    config = function()
      local yarepl = require 'yarepl'

      yarepl.setup {
        buflisted = true,
        scratch = true,
        ft = 'REPL',
        wincmd = 'belowright 15 split',
        metas = {
          aichat = { cmd = 'aichat', formatter = 'bracketed_pasting' },
          k = { cmd = 'rlwrap ngnk', formatter = 'bracketed_pasting' },
          radian = { cmd = 'radian', formatter = 'bracketed_pasting_no_final_new_line' },
          ipython = { cmd = 'ipython', formatter = 'bracketed_pasting' },
          python = { cmd = 'python', formatter = 'trim_empty_lines' },
          R = { cmd = 'R', formatter = 'trim_empty_lines' },
          bash = { cmd = 'bash', formatter = vim.fn.has 'linux' == 1 and 'bracketed_pasting' or 'trim_empty_lines' },
          zsh = { cmd = 'zsh', formatter = 'bracketed_pasting' },
        },
        close_on_exit = true,
        scroll_to_bottom_after_sending = true,
        format_repl_buffers_names = true,
      }
    end,
  },
  -- arraylang.lua
  {
    'https://codeberg.org/ngn/k',
    ft = 'k',
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. '/vim-k')
      vim.cmd [[
            autocmd! BufNew,BufRead *.k setf k
    ]]
    end,
  },
  {
    'mlochbaum/BQN',
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. '/editors/vim')
      vim.g.nvim_bqn = 'bqn'
      vim.cmd [[
          au! BufRead,BufNewFile *.bqn setf bqn
          au! BufRead,BufNewFile * if getline(1) =~ '^#!.*bqn$' | setf bqn | endif
    ]]
    end,
  },
  'https://git.sr.ht/~detegr/nvim-bqn',

  {
    'quarto-dev/quarto-nvim',
    dependencies = {
      'jmbuhr/otter.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    lazy = false,
    'godlygeek/tabular',
  },
  {
    'toppair/peek.nvim',
    event = { 'VeryLazy' },
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup {
        app = 'browser',
      }
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
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
    'catppuccin/nvim',
    name = 'catppuccin-latte',
    priority = 1000,
    lazy = false,
    config = function()
      if vim.env.COLORTERM == 'truecolor' then
        vim.opt.termguicolors = true
        vim.cmd.colorscheme 'catppuccin-latte'
      end
    end,
  },
}
