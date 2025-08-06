return {
  {
    'echasnovski/mini.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      { 'echasnovski/mini.extra' },
    },
    config = function()
      require('mini.ai').setup { n_lines = 500 }

      local hipatterns = require 'mini.hipatterns'
      hipatterns.setup {
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }

      require('mini.surround').setup()
      require('mini.files').setup {
        windows = {
          preview = true,
        },
      }

      require('mini.comment').setup()

      vim.keymap.set('n', '-', function()
        require('mini.files').open(vim.api.nvim_buf_get_name(0))
      end, { desc = 'open mini.files' })

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      require('mini.pick').setup()
      require('mini.extra').setup()

      local miniclue = require 'mini.clue'
      miniclue.setup {
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
        },

        clues = {
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
        window = {
          delay = 500,
        },
      }

      vim.keymap.set('n', '<C-p>', function()
        require('mini.pick').builtin.files { tool = 'rg', extra_args = { '--files', '--hidden', '--glob', '!**/.git/*' } }
      end, { desc = 'Find files (fd/rg)' })
      vim.keymap.set('n', '<leader><leader>', function()
        require('mini.pick').builtin.buffers()
      end, { desc = '[F]ind existing [b]uffers' })

      vim.keymap.set('n', '<leader>sg', function()
        require('mini.pick').builtin.grep_live()
      end, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sh', function()
        require('mini.pick').builtin.help()
      end, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', function()
        require('mini.extra').pickers.keymaps()
      end, { desc = '[S]earch [K]eymaps' })
    end,
  },
}
