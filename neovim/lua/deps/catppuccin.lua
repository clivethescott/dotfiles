return {
  "catppuccin/nvim",
  name = "catppuccin",
  event = 'VeryLazy',
  lazy = true,
  -- priority = 1000,
  opts = {
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
