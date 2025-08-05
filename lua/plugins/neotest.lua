---@diagnostic disable: missing-fields
local config = function()
  local neotest = require 'neotest'

  neotest.setup {
    adapters = {
      require 'neotest-python' {
        args = { '--capture=no' },
        is_test_file = function(file)
          return string.match(file, '^.+%.py$') ~= nil
        end,
      },
      require 'neotest-rust' {
        args = { '--no-capture' },
        dap_adapter = 'lldb',
      },
    },
  }

  vim.api.nvim_create_autocmd('BufEnter', {
    callback = vim.schedule_wrap(function(args)
      if vim.bo.filetype == 'neotest-output' then
        vim.api.nvim_buf_set_keymap(args.buf, 'n', 'q', '', {
          callback = function()
            pcall(vim.api.nvim_buf_delete, args.buf, { force = true })
          end,
        })
      end
    end),
  })
end

local keys = {
  {
    '<leader>tj',
    function()
      require('neotest').jump.next { status = 'failed' }
    end,
    desc = 'jump to next failed test',
  },
  {
    '<leader>tk',
    function()
      require('neotest').jump.prev { status = 'failed' }
    end,
    desc = 'jump to previous failed test',
  },
  {
    '<leader>tr',
    function()
      require('neotest').run.run()
    end,
    desc = 'run nearest test',
  },
  {
    '<leader>tR',
    function()
      require('neotest').run.run(vim.fn.expand '%')
    end,
    desc = 'run all tests in current file',
  },
  {
    '<leader>tw',
    function()
      require('neotest').watch.toggle()
    end,
    desc = 'watch nearest test',
  },
  {
    '<leader>td',
    function()
      require('neotest').run.run { strategy = 'dap' }
    end,
    desc = 'debug the nearest test',
  },
  {
    '<leader>tD',
    function()
      require('neotest').run.run_last { strategy = 'dap' }
    end,
    desc = 'debug the last nearest test',
  },
  {
    '<leader>ts',
    function()
      require('neotest').run.stop()
    end,
    desc = 'stop running tests',
  },
  {
    '<leader>ta',
    function()
      require('neotest').run.attach()
    end,
    desc = 'attach to the nearest test',
  },
  {
    '<leader>to',
    function()
      require('neotest').output.open { auto_close = true, enter = true }
    end,
    desc = 'open result window',
  },
  {
    '<leader>tO',
    function()
      require('neotest').summary.toggle()
    end,
    desc = 'toggle summary window',
  },
}

return {
  'nvim-neotest/neotest',
  config = config,
  keys = keys,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'haydenmeade/neotest-jest',
    'marilari88/neotest-vitest',
    'nvim-neotest/neotest-python',
    'rouge8/neotest-rust',
  },
}
