return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      presets = {
        operators = false,
        motions = false,
      },
    },
  },
  keys = {
    {
      "<space>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Show which key",
    },
  },
}
