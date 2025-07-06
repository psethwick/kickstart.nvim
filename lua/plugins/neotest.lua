return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',

      -- adapters
      'nvim-neotest/neotest-python',
      'rouge8/neotest-rust',
      'Issafalcon/neotest-dotnet',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-dotnet',
          require 'neotest-rust',
          require 'neotest-python' {
            dap = { justMyCode = false },
            cwd = function(path)
              local current = vim.fn.fnamemodify(path, ':h')
              while current ~= '/' and current ~= '' do
                if vim.fn.filereadable(current .. '/' .. 'pyproject.toml') then
                  return current
                end
                current = vim.fs.normalize(vim.fn.fnamemodify(current, ':p:h'))
              end
              return vim.fn.getcwd()
            end,
          },
        },
      }
    end,
  },
}
