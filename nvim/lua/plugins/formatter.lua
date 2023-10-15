return {
  "mhartington/formatter.nvim", -- non-LSP formatting support
  ft = { 'python' },
  event = 'VeryLazy',
  config = function()
    require('formatter').setup {
      filetype = {
        python = {
          require 'formatter.filetypes.python'.black,
        }
      }
    }
  end
}
