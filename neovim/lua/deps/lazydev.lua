return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  dependencies = {
    { 'DrKJeff16/wezterm-types', lazy = true },
  },
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      "~/.config/wezterm",
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "Snacks.nvim",        words = { "Snacks" } },
      { path = 'wezterm-types',      mods = { 'wezterm' } },
    },
  },
}
