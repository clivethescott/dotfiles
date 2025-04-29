return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    search = {
      multi_window = false,
      mode = 'fuzzy',
    },
    jump = {
      autojump = true,
    },
    label = {
      rainbow = {
        enabled = true,
      }
    },
    modes = {
      char = {
        enabled = false,
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "<space>j", mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash" },
    { "r",        mode = "o",               function() require("flash").remote() end, desc = "Remote Flash" },
  },
}
