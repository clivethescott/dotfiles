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
        'gopls', 'html', 'jsonls', 'rust_analyzer', 'lua_ls', 'pyright', 'tsserver',
        'tsserver', 'yamlls',
      }
    })
  end
}
