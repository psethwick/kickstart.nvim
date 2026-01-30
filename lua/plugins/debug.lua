return {
  {
    'igorlfs/nvim-dap-view',
    opts = {},
  },
  {
    'mfussenegger/nvim-dap',

    dependencies = {
      'nvim-neotest/nvim-nio',

      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      'leoluz/nvim-dap-go',
      'mfussenegger/nvim-dap-python',
      'stevearc/overseer.nvim',
    },
    keys = {
      {
        '<F5>',
        function()
          require('dap').continue()
        end,
        desc = 'Debug: Start/Continue',
      },
      {
        '<F1>',
        function()
          require('dap').step_into()
        end,
        desc = 'Debug: Step Into',
      },
      {
        '<F2>',
        function()
          require('dap').step_over()
        end,
        desc = 'Debug: Step Over',
      },
      {
        '<F3>',
        function()
          require('dap').step_out()
        end,
        desc = 'Debug: Step Out',
      },
      {
        '<leader>b',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Debug: Toggle Breakpoint',
      },
      {
        '<leader>B',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint',
      },
    },
    config = function()
      local dap = require 'dap'

      require('mason-nvim-dap').setup {
        automatic_installation = true,
        automatic_setup = true,

        handlers = {},

        ensure_installed = {
          'delve',
        },
      }

      dap.adapters.lldb = {
        type = 'executable',
        command = '/sbin/lldb-vscode',
        name = 'lldb',
      }

      local lldb_config = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
      }

      dap.configurations.cpp = lldb_config
      dap.configurations.c = lldb_config
      dap.configurations.rust = lldb_config

      local vscode_ext = require 'dap.ext.vscode'
      vscode_ext.json_decode = require('overseer.json').decode
      vscode_ext.load_launchjs(nil, {
        ['pwa-node'] = {
          'typescript',
          'javascript',
          'typescriptreact',
        },
      })
      require('dap-go').setup()
      require('dap-python').setup 'python'

      dap.listeners.after.event.initialized['dap-view-toggle'] = function()
        require('dap-view').toggle()
      end

      dap.listeners.before.event.terminated['dap-view-toggle'] = function()
        require('dap-view').toggle()
      end

      local function debug_pytest_bdd_picker()
        local pick = require 'mini.pick'

        -- Use pytest to collect tests.
        -- We use 'args' to ensure we only get the test IDs
        local cmd = 'pytest -q --collect-only --nd --color=no'

        -- Run the command and capture output
        local handle = io.popen(cmd)
        if not handle then
          return
        end
        local result = handle:read '*a'
        handle:close()

        local items = {}
        for line in result:gmatch '[^\r\n]+' do
          -- Clean up the pytest output to get clean scenario/test names
          if not line:match 'collected' and line ~= '' then
            table.insert(items, line)
          end
        end

        pick.start {
          source = {
            items = items,
            name = 'Debug BDD Scenario',
            choose = function(item)
              local dap = require 'dap'
              local dap_python = require 'dap-python'
              -- local dapview = require('dapview') -- dapview is already handled by global listeners

              -- 1. Setup a listener: When the session starts, open dapview
              -- This is handled by global listeners now, so we remove the redundant local listener
              -- dap.listeners.after.event_initialized["dapview_config"] = function()
              --   dapview.open()
              -- end

              -- 2. Launch the debugger with the selected -k filter
              dap_python.debug_selection {
                module = 'pytest',
                args = { '-k', item },
                -- Ensure Django env is loaded if your shell doesn't do it automatically
                -- env = { DJANGO_SETTINGS_MODULE = "my_project.settings" },
                console = 'integratedTerminal',
              }
            end,
          },
        }
      end

      vim.keymap.set('n', '<leader>db', debug_pytest_bdd_picker, { desc = 'Fuzzy debug BDD with dapview' })
    end,
  },
}
