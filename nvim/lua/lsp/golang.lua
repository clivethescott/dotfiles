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
      usePlaceholders = true,
    },
  }

  -- ./golangci-lint help linters
  local lint_command = { "golangci-lint", "run", "--out-format", "json" }
  local custom_lint_config = false

  if custom_lint_config then
    local enabled_presets = "bugs,comment,metalinter,sql,style,unused"
    local disabled_linters = "exhaustivestruct,golint,interfacer,scopelint,wsl"

    table.insert(lint_command, "--presets")
    table.insert(lint_command, enabled_presets)
    table.insert(lint_command, "--disable")
    table.insert(lint_command, disabled_linters)
  end

  -- go/brew install golangci-lint or equiv
  lspconfig.golangci_lint_ls.setup {
    capabilities = capabilities,
    filetypes = { 'go' },
    on_attach = on_attach,
    init_options = {
      command = lint_command,
    }
  }
end

return M
