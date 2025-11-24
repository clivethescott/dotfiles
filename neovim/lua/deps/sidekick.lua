local adapter = vim.g.is_work_pc and "amazon_q" or "claude" -- TODO: use copilot CLI when org allowed

return {
  {
    "folke/sidekick.nvim",
    opts = {
      nes = {
        enabled = false, -- vim.g.is_work_pc and vim.b.sidekick_nes ~= false and vim.g.sidekick_nes ~= false,
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
        tools = {
          amazon_q = {
            cmd = { vim.fs.joinpath(vim.env.HOME .. '/.local/bin/kiro-cli') }
          }
        }
      },
      copilot = {
        enabled = vim.g.is_work_pc,
      },
    },
    keys = {
      {
        "<c-.>",
        function()
          require("sidekick.cli").toggle({ name = adapter, focus = true })
        end,
        mode = { "n", "x", "i", "t" },
        desc = "Sidekick Toggle",
      },
      {
        "<space>af",
        function() require("sidekick.cli").send({ msg = "{file}" }) end,
        desc = "Sidekick send file",
      },
      {
        "<space>av",
        function() require("sidekick.cli").send({ msg = "{selection}" }) end,
        mode = { 'x' },
        desc = "Sidekick send visual selection",
      },
      {
        "<space>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        desc = "Sidekick Ask Prompt",
        mode = { "n", "v" },
      },
    },
  },

}
