return {
  "folke/flash.nvim",
  event = "LspAttach",
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
        enabled = false,
        keys = { "f", "F", "t", "T", ";", "," },
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
      "U",
      mode = { "n", "x", "o" },
      function() require("flash").jump() end,
      desc = "Flash"
    },
    -- { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    {
      "S",
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
