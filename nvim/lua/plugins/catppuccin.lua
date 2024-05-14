return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require 'catppuccin'.setup {
      term_colors = true,
      integrations = {
        notify = true,
      },
    }

    vim.cmd([[colorscheme catppuccin-macchiato]])
  end,
}
