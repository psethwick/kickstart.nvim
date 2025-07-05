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
  -- {
  --   'quarto-dev/quarto-nvim',
  --   dependencies = {
  --     'jmbuhr/otter.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  -- },
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
}
