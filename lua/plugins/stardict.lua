return {
  'psethwick/vim-stardict',
  config = function()
    vim.g.stardict_split_horizontal = 0
  end,
  keys = { {
    '<leader>K',
    ':StarDictCursor<cr>',
  } },
}
