return {
  {
    'https://codeberg.org/ngn/k',
    ft = 'k',
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. '/vim-k')
      vim.cmd [[
            autocmd! BufNew,BufRead *.k setf k
    ]]
    end,
  },
  {
    'mlochbaum/BQN',
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. '/editors/vim')
      vim.g.nvim_bqn = 'bqn'
      vim.cmd [[
          au! BufRead,BufNewFile *.bqn setf bqn
          au! BufRead,BufNewFile * if getline(1) =~ '^#!.*bqn$' | setf bqn | endif
    ]]
    end,
  },
  'https://git.sr.ht/~detegr/nvim-bqn',
}
