local is_work_pc = vim.env.IS_WORK_PC == "true"
local adapter = is_work_pc and "amazon_q" or "claude" -- TODO: use copilot CLI when org allowed

return {
  {
    "folke/sidekick.nvim",
    opts = {
      nes = {
        enabled = is_work_pc and vim.b.sidekick_nes ~= false,
        trigger = {
          -- events that trigger sidekick next edit suggestions
          -- events = { "InsertLeave", "TextChanged", "User SidekickNesDone" },
          events = { "BufWritePost" },
        },
      },
      cli = {
        mux = {
          enabled = false, -- only supports tmux/zellij
        },
      },
      copilot = {
        enabled = is_work_pc,
      },
    },
    keys = {
      {
        "<c-.>",
        function()
          require("sidekick.cli").focus()
        end,
        mode = { "n", "x", "i", "t" },
        desc = "Sidekick Switch Focus",
      },
      {
        "<space>ao",
        function()
          require("sidekick.cli").toggle({ focus = true, name = adapter })
        end,
        desc = "Sidekick Toggle CLI",
        mode = { "n", "v" },
      },
      {
        "<space>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        desc = "Sidekick Ask Prompt",
        mode = { "n", "v" },
      },
      {
        "<space>au",
        function()
          require("sidekick.nes").update()
        end,
        desc = "Sidekick Update NES",
      },
      {
        "<space>ax",
        function()
          require("sidekick").clear()
        end,
        desc = "Sidekick NES clear",
      },
      {
        "<space>aa",
        function()
          require("sidekick.nes").apply()
        end,
        desc = "Sidekick NES jump or apply",
      },
      {
        "<c-y>",
        function()
          require("sidekick.nes").apply()
        end,
        desc = "Sidekick NES jump or apply",
      },
    },
  },

}
