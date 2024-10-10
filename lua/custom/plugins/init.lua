vim.cmd [[
  autocmd BufEnter *.slint :setlocal filetype=slint
]]

return {
  {
    'ej-shafran/compile-mode.nvim',
    tag = 'v5.2.0',
    -- you can just use the latest version:
    -- branch = "latest",
    -- or the most up-to-date updates:
    -- branch = "nightly",
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- if you want to enable coloring of ANSI escape codes in
      -- compilation output, add:
      -- { "m00qek/baleia.nvim", tag = "v1.3.0" },
    },
    config = function()
      ---@type CompileModeOpts
      vim.g.compile_mode = {
        -- to add ANSI escape code support, add:
        -- baleia_setup = true,
      }
    end,
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
  -- {
  --   'frankroeder/parrot.nvim',
  --   tag = 'v0.5.0',
  --   dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
  --   -- optionally include "rcarriga/nvim-notify" for beautiful notifications
  --   config = function()
  --     require('parrot').setup {
  --       -- Providers must be explicitly added to make them available.
  --       providers = {
  --         pplx = {
  --           api_key = os.getenv 'PERPLEXITY_API_KEY',
  --           -- OPTIONAL
  --           -- gpg command
  --           -- api_key = { "gpg", "--decrypt", vim.fn.expand("$HOME") .. "/pplx_api_key.txt.gpg"  },
  --           -- macOS security tool
  --           -- api_key = { "/usr/bin/security", "find-generic-password", "-s pplx-api-key", "-w" },
  --         },
  --         openai = {
  --           api_key = os.getenv 'OPENAI_API_KEY',
  --         },
  --         anthropic = {
  --           api_key = os.getenv 'ANTHROPIC_API_KEY',
  --         },
  --         mistral = {
  --           api_key = os.getenv 'MISTRAL_API_KEY',
  --         },
  --         gemini = {
  --           api_key = os.getenv 'GEMINI_API_KEY',
  --         },
  --         groq = {
  --           api_key = os.getenv 'GROQ_API_KEY',
  --         },
  --         ollama = {}, -- provide an empty list to make provider available
  --       },
  --     }
  --   end,
  -- },
  'stevearc/overseer.nvim',
  {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {
      keymaps = {
        ['g?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['<C-s>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
        ['<C-h>'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
        ['<C-t>'] = { 'actions.select', opts = { tab = true }, desc = 'Open the entry in new tab' },
        ['<C-v>'] = 'actions.preview', -- was <C-p> and used to upset me
        ['<C-c>'] = 'actions.close',
        ['<C-l>'] = 'actions.refresh',
        ['-'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['`'] = 'actions.cd',
        ['~'] = { 'actions.cd', opts = { scope = 'tab' }, desc = ':tcd to the current oil directory', mode = 'n' },
        ['gs'] = 'actions.change_sort',
        ['gx'] = 'actions.open_external',
        ['g.'] = 'actions.toggle_hidden',
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = false,
      view_options = {
        show_hidden = true,
      },
    },
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
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Git Neogit' },
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
