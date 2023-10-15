return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    search = {
      multi_window = false,
      incremental = true,
    },
    modes = {
      char = {
        jump_labels = true,
        multi_line = true,
        enabled = true
      }
    },
    jump = {
      -- automatically jump when there is only one match
      autojump = false
    },
    label = {
      -- Enable this to use rainbow colors to highlight labels
      -- Can be useful for visualizing Treesitter ranges.
      rainbow = {
        enabled = true
      }
    }
  },
  -- stylua: ignore
  keys = {
    {
      "<space>j",
      mode = { "n", "x", "o" },
      function() require("flash").jump() end,
      desc = "Flash"
    },
    {
      "<space>J",
      mode = { "n", "x", "o" },
      function() require("flash").treesitter() end,
      desc = "Flash Treesitter"
    },
    {
      "r",
      mode = "o",
      function() require("flash").remote() end,
      desc = "Remote Flash"
    },
    {
      "R",
      mode = { "o", "x" },
      function() require("flash").treesitter_search() end,
      desc = "Remote Flash Treesitter"
    },
  },
}
