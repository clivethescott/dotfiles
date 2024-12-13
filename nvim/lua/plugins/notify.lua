return {
  'rcarriga/nvim-notify',
  event = 'LspAttach',
  config = function()
    local notify = require 'notify'
    notify.setup({
      ---@diagnostic disable-next-line: missing-fields
      timeout = 500
    })
    vim.notify = notify
  end
}
