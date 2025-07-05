return {
  {
    'catppuccin/nvim',
    name = 'catppuccin-latte',
    priority = 1000,
    lazy = false,
    config = function()
      if vim.env.COLORTERM == 'truecolor' then
        vim.opt.termguicolors = true
        vim.cmd.colorscheme 'catppuccin-latte'
      end
    end,
  },
}
