return {
  "stevearc/aerial.nvim",
  event = 'LspAttach',
  cond = false,
  config = function()
    require 'aerial'.setup {
      layout = {
        min_width = 30,
      }
    }
  end,
}
