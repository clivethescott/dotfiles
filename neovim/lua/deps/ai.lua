local adapter = vim.env.IS_WORK_PC == "true" and "copilot" or "ollama"
return {
  {
    "olimorris/codecompanion.nvim",
    cmd = {'CodeCompanionChat', 'CodeCompanion'},
    opts = {
      strategies = {
        chat = {
          adapter = adapter,
        },
        inline = {
          adapter = adapter,
        },
        cmd = {
          adapter = adapter,
        }
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "qwen3:1.7b",
              },
            },
          })
        end,
      },
    },
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { '<space>ao', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'Toggle Chat' },
      { '<space>ac', '<cmd>CodeCompanionActions<cr>',     desc = 'Code Companion actions' },
      {
        mode = { 'n', 'v' },
        '<space>ai',
        '<cmd>CodeCompanion /explain',
        desc = 'Code Companion actions'
      },
    }
  },
  {
    "zbirenbaum/copilot.lua",
    cond = vim.env.IS_WORK_PC == "true",
    cmd = "Copilot",
    event = "VeryLazy",
    opts = {
      -- recommended to disable these, can interfere with blink, see https://github.com/giuxtaposition/blink-cmp-copilot
      panel = { enabled = false },
      suggestion = { enabled = false },
      server_opts_overrides = {
        settings = {
          telemetry = {
            telemetryLevel = 'off',
          },
        },
      },
    }
  }
}
