-- local adapter = vim.g.is_work_pc and "amazon_q" or "claude" -- TODO: use copilot CLI when org allowed
local adapter = "claude"

return {
  "sidekick.nvim",
  after = function()
    require('sidekick').setup({
      nes = {
        enabled = vim.b.sidekick_nes ~= false,
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
          },
        }
      },
      copilot = {
        enabled = vim.g.is_work_pc,
      },
    })
  end,
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
      "<space>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      desc = "Sidekick Ask Prompt",
      mode = { "n", "v" },
    },
  },
}
