return {
  "catppuccin/nvim",
  name = "catppuccin",
  event = 'DeferredUIEnter',
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
    custom_highlights = function(colors)
      return {
        NormalFloat = { bg = colors.base },
        FloatBorder = { bg = colors.base, fg = colors.overlay1 },
      }
    end,
    dim_inactive = {
      enabled = true,    -- dims the background color of inactive window
      shade = "light",
      percentage = 0.30, -- percentage of the shade to apply to the inactive window
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
