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
        'golangci_lint_ls', 'gopls', 'html', 'jsonls',
        'lua_ls', 'pyright', 'ruff_lsp', 'tsserver', 'terraformls',
      }
    })
  end
}
