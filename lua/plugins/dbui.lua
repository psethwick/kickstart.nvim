return {
  {
    'kndndrj/nvim-dbee',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    build = function()
      require('dbee').install()
    end,
    cmd = { 'Dbee' },
    init = function()
      vim.keymap.set('n', '<leader>db', ':Dbee<CR>', { desc = '[D]ata[b]ase UI' })
    end,
    config = function()
      require('dbee').setup()
    end,
  },
}
