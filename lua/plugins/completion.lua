return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    -- use a release tag to download pre-built binaries
    version = '1.*',

    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      keymap = { preset = 'default' },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = { documentation = { auto_show = false } },

      sources = {
        default = { 'lsp', 'path', 'buffer' },
        per_filetype = {
          sql = { 'snippets', 'dadbod', 'buffer' },
        },
        providers = {
          dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
        },
      },

      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
}
