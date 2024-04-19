return {
  'j-hui/fidget.nvim',
  tag = "v1.0.0",
  event = 'LspAttach',
  opts = {
    progress = {
      suppress_on_insert = true,
      display = {
        overrides = {
          jdtls = {      -- Name of LSP client
            ignore = true, -- Ignore notifications from this source
          },
          lua_ls = {
            ignore = true, -- Ignore notifications from this source
          }
        },
      }
    },
  }
}
