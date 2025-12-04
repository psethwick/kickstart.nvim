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
    event = 'BufReadPre',
    dependencies = {
      'https://git.sr.ht/~detegr/nvim-bqn',
    },
    config = function(plugin)
      vim.filetype.add {
        extension = {
          bqn = 'bqn',
        },
      }
	  vim.g.nvim_bqn = 'bqn'
      vim.opt.rtp:append(plugin.dir .. '/editors/vim')
    end,
  },
}
