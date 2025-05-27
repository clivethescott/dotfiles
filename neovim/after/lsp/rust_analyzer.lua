return {
  -- toolchain installs a wrapper that isn't the real binary
  cmd = { 'rust-analyzer' },
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {     -- example
        enable = true,
      }
    }
  }
}
