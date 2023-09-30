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
      on_attach(client, bufnr)
    end,
    settings = {
      gopls = {
        semanticTokens = true,
        codelenses = {
          generate = true,
        },
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
        gofumpt = true,
      },
    },
    init_options = {
      usePlaceholders = false,
    },
  }

end

return M
