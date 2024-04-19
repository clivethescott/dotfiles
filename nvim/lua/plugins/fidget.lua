return {
  'j-hui/fidget.nvim',
  tag = "v1.0.0",
  event = 'LspAttach',
  opts = {
    progress = {
      suppress_on_insert = true,
      ignore = { 'lua_ls' },
      display = {
        render_limit = 5,
        done_ttl = 1,
        progress_ttl = 5,
      }
    },
  }
}
