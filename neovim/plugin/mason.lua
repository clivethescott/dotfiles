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
  'prettier',
  -- rust
  'rust-analyzer',
  -- go
  'glow',
  'gofumpt',
  'gopls',
  'typescript-language-server',
  -- 'tsgo',
  'lua-language-server',
  'fish-lsp',
  'smithy-language-server',
  'docker-language-server',
  'terraform-ls',
  'copilot-language-server',
  'helm-ls',
  'tinymist',
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

vim.schedule(function()
  vim.pack.add({ { src = 'https://github.com/mason-org/mason.nvim' } })

  require 'mason'.setup()
  install_missing()

  vim.keymap.set('n', '<space>om', '<cmd>Mason<cr>', { desc = 'Mason' })
end)
