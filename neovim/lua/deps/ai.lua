local is_work_pc = vim.env.IS_WORK_PC == "true"
local adapter = is_work_pc and "copilot" or "claude"

return {
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        mux = {
          enabled = false, -- only supports tmux/zellij
        },
      },
      copilot = {
        enabled = false,
      },
      prompts = {
        explain = "Explain this code",
        structure = "Explain how this code is structured. What are the main things I should know to get started",
        diagnostics = {
          msg = "What do the diagnostics in this file mean?",
          diagnostics = true,
        },
        diagnostics_all = {
          msg = "Can you help me fix these issues?",
          diagnostics = { all = true },
        },
        fix = {
          msg = "Can you fix the issues in this code?",
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
    },
  },

}
