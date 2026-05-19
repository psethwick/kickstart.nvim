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
  {
    'dmtrKovalenko/fff.nvim',
    build = function()
      -- downloads a prebuilt binary or falls back to cargo build
      require('fff.download').download_or_build_binary()
    end,
    -- for nixos:
    -- build = "nix run .#release",
    opts = {
      debug = {
        enabled = true,
        show_scores = true,
      },
    },
    lazy = false, -- the plugin lazy-initialises itself
    keys = {
      {
        'ff',
        function()
          require('fff').find_files()
        end,
        desc = 'FFFind files',
      },
      {
        'fg',
        function()
          require('fff').live_grep()
        end,
        desc = 'LiFFFe grep',
      },
      {
        'fz',
        function()
          require('fff').live_grep { grep = { modes = { 'fuzzy', 'plain' } } }
        end,
        desc = 'Live fffuzy grep',
      },
      {
        'fc',
        function()
          require('fff').live_grep { query = vim.fn.expand '<cword>' }
        end,
        desc = 'Search current word',
      },
    },
  },
}
