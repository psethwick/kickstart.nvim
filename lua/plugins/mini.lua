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

      local pickers = require('mini.extra').pickers

      vim.keymap.set('n', '<leader>sf', function()
        require('mini.pick').builtin.files()
      end, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<C-p>', function()
        require('mini.pick').builtin.files { tool = 'rg', extra_args = { '--files', '--hidden', '--glob', '!**/.git/*' } }
      end, { desc = 'Find files (fd/rg)' })
      vim.keymap.set('n', '<leader>sb', function()
        require('mini.pick').builtin.buffer_lines()
      end, { desc = '[S]earch [B]uffer' })
      vim.keymap.set('n', '<leader><leader>', function()
        require('mini.pick').builtin.buffers()
      end, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>ss', function()
        require('mini.pick').builtin()
      end, { desc = '[S]elect Picker' })

      vim.keymap.set('n', '<leader>sw', function()
        require('mini.pick').builtin.grep_word()
      end, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', function()
        require('mini.pick').builtin.grep_live()
      end, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>s/', function()
        require('mini.pick').builtin.grep_live { only_open = true, prompt_title = 'Live Grep in Open Files' }
      end, { desc = '[S]earch [/] in Open Files' })
      vim.keymap.set('n', '<leader>sd', function()
        pickers.diagnostic { scope = 'all' }
      end, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sh', function()
        require('mini.pick').builtin.help()
      end, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', function()
        require('mini.pick').builtin.keymaps()
      end, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sn', function()
        require('mini.pick').builtin.files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
      vim.keymap.set('n', '<leader>sr', function()
        require('mini.pick').builtin.resume()
      end, { desc = '[S]earch [R]esume' }) -- or just closes and resumes pickers
      vim.keymap.set('n', '<leader>s.', function()
        require('mini.pick').builtin.oldfiles()
      end, { desc = '[S]earch Recent Files ("." for repeat)' })
    end,
  },
}
