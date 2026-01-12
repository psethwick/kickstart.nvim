return {
  {
    'saghen/blink.compat',
    -- use v2.* for blink.cmp v1.*
    version = '2.*',
    lazy = true,
    opts = {},
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    -- use a release tag to download pre-built binaries
    version = '1.*',
    dependencies = {
      {
        'mattiasmts/cmp-dbee',
        dependencies = {
          { 'kndndrj/nvim-dbee' },
        },
        ft = 'sql',
        opts = {},
      },
    },
    opts = {
      keymap = { preset = 'default' },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = { documentation = { auto_show = false } },
      sources = {
        default = { 'lsp', 'path', 'buffer' },
        per_filetype = {
          sql = { 'snippets', 'dbee', 'buffer' },
        },
        providers = {
          dbee = { name = 'cmp-dbee', module = 'blink.compat.source' },
        },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
}
