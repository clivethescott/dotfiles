return {
  -- toolchain installs a wrapper that isn't the real binary
  cmd = { 'rust-analyzer' },
  settings = {
    ['rust-analyzer'] = {
      diagnostics = { -- example
        enable = true,
        styleLints = {
          enable = true,
        },
      },
      inlayHints = {
        genericParameterHints = {
          lifetime = {
            enable = true,
          },
        },
      },
      completion = {
        limit = 30,
        hideDeprecated = true,
      },
      workspace = {
        cargo = {
          autoreload = true,
        },
        symbol = {
          search = {
            scope = 'workspace_and_dependencies', --default 'workspace'
            limit = 30,                           -- default 128
            kind = 'only_types',                  -- default only_types
          }
        }
      }
    }
  }
}
