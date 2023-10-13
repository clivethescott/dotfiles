return {
  "mhartington/formatter.nvim", -- non-LSP formatting support
  ft = { 'python' },
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
