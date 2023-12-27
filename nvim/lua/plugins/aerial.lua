return {
  "stevearc/aerial.nvim",
  event = 'LspAttach',
  config = function()
    require 'aerial'.setup {
      layout = {
        min_width = 30,
      }
    }
  end,
}
