---@type vim.lsp.Config
return {
  -- toolchain installs a wrapper that isn't the real binary
  cmd = { 'rust-analyzer' },
  ---@type lspconfig.settings.rust_analyzer
  settings = {
    ['rust-analyzer'] = {
      workspace = {
        cargo = {
          autoreload = true,
        },
        symbol = {
          search = {
            scope = 'workspace_and_dependencies', --default 'workspace'
            kind = 'only_types',                  -- default only_types
          }
        }
      }
    }
  }
}
