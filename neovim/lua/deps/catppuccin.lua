return {
  "catppuccin/nvim",
  name = "catppuccin",
  event = 'VeryLazy',
  lazy = true,
  priority = 1000,
  opts = {
    background = {
      dark = "mocha",
    },
    color_overrides = {
      mocha = {
        base = "#000000",
      },
    },
    flavour = 'mocha',
    dim_inactive = {
      enabled = true,    -- dims the background color of inactive window
      shade = "light",
      percentage = 0.50, -- percentage of the shade to apply to the inactive window
    },
    integrations = {
      gitsigns = true,
      treesitter = true,
      -- blink_cmp = true,
      fidget = true,
      fzf = true,
      lsp_trouble = true,
      which_key = true,
    },
  },
}
