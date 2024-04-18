return {
  'rcarriga/nvim-notify',
  event = 'LspAttach',
  config = function()
    local notify = require 'notify'
    notify.setup({
      timeout = 500
    })
    vim.notify = notify
  end
}
