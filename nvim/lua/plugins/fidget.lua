return {
  'j-hui/fidget.nvim',
  tag = "v1.0.0",
  event = 'LspAttach',
  opts = {
    progress = {
      suppress_on_insert   = true,
      ignore_done_already  = true,
      ignore_empty_message = true,
      ignore               = { 'lua_ls' },
      display              = {
        render_limit = 5,
        done_ttl = 0,
      }
    },
  },
}
