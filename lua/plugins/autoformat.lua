return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    config = function()
      local enabled = vim.env.NO_AUTOFORMAT ~= 'true'

      if enabled then
        require('conform').setup {
          notify_on_error = false,
          format_on_save = function(bufnr)
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = { c = true, cpp = true } --, cs = true }
            return {
              timeout_ms = 500,
              lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
            }
          end,
          formatters_by_ft = {
            lua = { 'stylua' },
            python = { 'ruff_format' },
            sql = { 'sql_formatter' },
            javascript = { 'prettier' },
            astro = { 'prettier' },
            typescript = { 'prettier' },
            typescriptreact = { 'prettier' },
          },
        }
      end
    end,
  },
}
