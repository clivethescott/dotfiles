-- https://mason-registry.dev/registry/list
local mason_packages = {
  'bash-language-server',
  'graphql-language-service-cli',
  'html-lsp',
  'json-lsp',
  'taplo',
  -- yaml
  'yaml-language-server',
  'yamlfmt',
  'yamllint',
  'kube-linter',
  -- python
  'ruff',
  'ty',
  'pyright',
  -- rust
  'rust-analyzer',
  -- go
  'glow',
  'gopls',
  -- 'typescript-language-server',
  'tsgo',
  'lua-language-server',
  'fish-lsp',
  'smithy-language-server',
  'docker-language-server',
  'terraform-ls',
  'copilot-language-server',
  'helm-ls',
  -- these are installed manually / not in mason registry
  -- 'kulala_ls',
  -- 'nushell',
}

local install_missing = function()
  local registry = require 'mason-registry'
  local installed = registry.get_installed_package_names()
  local needs_install = vim.tbl_filter(function(package)
    return not vim.tbl_contains(installed, package)
  end, mason_packages)
  if #needs_install > 0 then
    local packages_to_install = table.concat(needs_install, ' ')
    vim.cmd('MasonInstall ' .. packages_to_install)
  end
end

return {
  'mason.nvim',
  event = 'DeferredUIEnter',
  dependencies = {
    'nvim-lspconfig',
  },
  after = function()
    require 'mason'.setup()
    install_missing()
  end,
  keys = {
    { '<space>om', '<cmd>Mason<cr>', 'Mason' }
  }
}
