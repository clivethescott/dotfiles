return {
  'fidget.nvim',
  event = 'DeferredUIEnter',
  after = function()
    local fidget = require 'fidget'
    fidget.setup {
      notification = {
        override_vim_notify = true, -- Automatically override vim.notify() with Fidget
      },
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
    }
    vim.keymap.set('n', '<space>nh', fidget.notification.show_history, { desc = 'Show notification history' })
  end,
}
