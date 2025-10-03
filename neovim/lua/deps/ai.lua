local is_work_pc = vim.env.IS_WORK_PC == "true"
local adapter = is_work_pc and "amazonq" or "claude" -- TODO: use copilot CLI when org allowed

return {
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        mux = {
          enabled = false, -- only supports tmux/zellij
        },
        tools = {
          amazonq = { cmd = { "q", "chat" }, url = "https://aws.amazon.com/q" },
        },
        prompts = {
          explain = "Explain this code",
          architecture = "Can you explain how this code is structured",
          fix = {
            msg = "Can you help me fix these issues?",
            diagnostics = true,
          },
          review = {
            msg = "Can you review this code for any issues or improvements?",
            diagnostics = true,
          },
          optimize = "How can this code be optimized?",
          tests = "Can you write tests for this code?",
          file = { location = { row = false, col = false } },
          position = {},
        },
      },
      copilot = {
        enabled = false,
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
          require("sidekick.cli").select_prompt()
        end,
        desc = "Sidekick Ask Prompt",
        mode = { "n", "v" },
      },
      {
        "<space>anu",
        function()
          require("sidekick.nes").update()
        end,
        desc = "Sidekick Update NES",
      },
      {
        "<space>ann",
        function()
          require("sidekick").nes_jump_or_apply()
        end,
        desc = "Sidekick NES jump or apply",
      },
      {
        "<space>anc",
        function()
          require("sidekick").clear()
        end,
        desc = "Sidekick NES clear",
      }
    },
  },

}
