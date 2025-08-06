return {
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = { 'tpope/vim-dadbod', 'kristijanhusak/vim-dadbod-completion' },
    cmd = { 'DBUI' },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.keymap.set('n', '<leader>db', ':DBUI<CR>', { desc = '[D]ata[b]ase UI' })
    end,
  },
}
