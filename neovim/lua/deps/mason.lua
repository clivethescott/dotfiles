return {
  'mason-org/mason.nvim',
  event = 'VeryLazy',
  dependencies = {
    'neovim/nvim-lspconfig',
  },
  config = true,
  keys = {
    { '<space>om', '<cmd>Mason<cr>', 'Mason' }
  }
}
