local is_work_pc = vim.env.IS_WORK_PC == "true"
local adapter = is_work_pc and "copilot" or "claude-code"

return {
  {
    name = 'amazonq',
    cond = is_work_pc,
    url = 'https://github.com/awslabs/amazonq.nvim.git',
    cmd = { 'AmazonQ' },
    opts = {
      ssoStartUrl = 'https://twdc-qdeveloper.awsapps.com/start',
      filetypes = {
        'amazonq', 'bash', 'java', 'python', 'typescript', 'javascript',
        'scala', 'sh', 'sql', 'go', 'rust', 'lua', 'hcl', 'terraform', 'yaml'
      },
      on_chat_open = function()
        vim.cmd [[
      vertical split
      set wrap breakindent number relativenumber nolist
    ]]
      end,
    },
    keys = {
      { '<space>aq', '<cmd>AmazonQ toggle<cr>', desc = 'Toggle Q' },
    }
  },
  {
    "yetone/avante.nvim",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      input = {
        provider = "snacks"
      },
      windows = {
        width = 40,
      },
      -- this file can contain specific instructions for your project
      instructions_file = "avante.md",
      -- provider = "claude-code",
      provider = adapter,
      selector = {
        ---@type avante.SelectorProvider "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope" | fun(selector: avante.ui.Selector): nil
        provider = 'fzf_lua'
      }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        "zbirenbaum/copilot.lua",
        cond = is_work_pc,
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
    },
    keys = {
      { '<space>ao', '<cmd>AvanteToggle<cr>', desc = 'Toggle Chat' },
    }
  },

}
