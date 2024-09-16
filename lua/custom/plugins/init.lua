vim.cmd [[
  autocmd BufEnter *.slint :setlocal filetype=slint
]]

return {
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
    opts = {},
    keys = {
      -- TODO: stop this stealing C-P
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
