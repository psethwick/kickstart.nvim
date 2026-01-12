return {
  'mfussenegger/nvim-dap',

  dependencies = {
    -- 'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text',

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
    -- {
    --   '<F7>',
    --   function()
    --     require('dapui').toggle()
    --   end,
    --   desc = 'Debug: See last session result.',
    -- },
  },
  config = function()
    local dap = require 'dap'
    -- local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      automatic_setup = true,

      handlers = {},

      ensure_installed = {
        'delve',
      },
    }

    require('nvim-dap-virtual-text').setup {}

    -- dapui.setup {
    --   -- Set icons to characters that are more likely to work in every terminal.
    --   --    Feel free to remove or use ones that you like more! :)
    --   --    Don't feel like these are good choices.
    --   icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    --   controls = {
    --     icons = {
    --       pause = '⏸',
    --       play = '▶',
    --       step_into = '⏎',
    --       step_over = '⏭',
    --       step_out = '⏮',
    --       step_back = 'b',
    --       run_last = '▶▶',
    --       terminate = '⏹',
    --       disconnect = '⏏',
    --     },
    --   },
    -- }

    -- dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    -- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    -- dap.listeners.before.event_exited['dapui_config'] = dapui.close
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
  end,
}
