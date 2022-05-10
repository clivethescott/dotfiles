local M = {}
M.setup = function(on_attach, capabilities)
  local ok, lspconfig = pcall(require, 'lspconfig')
  if not ok then
    return
  end

  -- Requires go install golang.org/x/tools/gopls@latest
  lspconfig.gopls.setup {
    capabilities = capabilities,
    filetypes = { 'go' },
    on_attach = function(client, bufnr)
      -- These will be handled by null-ls goimports
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      on_attach(client, bufnr)
    end,
    settings = {
      gopls = {
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
      },
    },
    init_options = {
      usePlaceholders = true,
    },
  }

  -- brew install golangci-lint or equiv
  lspconfig.golangci_lint_ls.setup {
    capabilities = capabilities,
    filetypes = { 'go' },
    on_attach = on_attach,
  }
end

return M
