return {
  'williamboman/mason.nvim',
  event = 'VeryLazy',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  },
  config = function()
    require('mason').setup()

    require 'mason-lspconfig'.setup({
      ensure_installed = {
        'jsonls', 'rust_analyzer', 'lua_ls', 'ts_ls', 'gopls', 'ruff', 'pyright'
      }
    })
  end,
  keys = {
    { '<space>om', '<cmd>Mason<cr>', 'Mason' }
  }
}
