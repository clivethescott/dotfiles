return {
  -- toolchain installs a wrapper that isn't the real binary
  cmd = { 'rust-analyzer' },
  settings = {
    ['rust-analyzer'] = {
      diagnostics = { -- example
        enable = true,
      },
      completion = {
        limit = 128,
        hideDeprecated = false,
      },
      workspace = {
        cargo = {
          autoreload = true,
        },
        symbol = {
          search = {
            scope = 'workspace_and_dependencies', --default 'workspace'
            limit = 128,                           -- default 128
            kind = 'only_types',                  -- default only_types
          }
        }
      }
    }
  }
}
