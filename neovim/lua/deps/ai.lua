local adapter = "copilot"
local is_work_pc = false -- vim.env.IS_WORK_PC == "true"
local mcphub_enabled = false

return {
  {
    name = 'amazonq',
    cond = is_work_pc,
    url = 'https://github.com/awslabs/amazonq.nvim.git',
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
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cond = mcphub_enabled,
    event = 'VeryLazy',
    build = "npm install -g mcp-hub@latest",
    config = true,
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
      provider = "copilot",
      selector = {
        ---@type avante.SelectorProvider "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope" | fun(selector: avante.ui.Selector): nil
        provider = 'fzf_lua'
      }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { '<space>ao', '<cmd>AvanteToggle<cr>', desc = 'Toggle Chat' },
    }
  },
  {
    "olimorris/codecompanion.nvim",
    cmd = { 'CodeCompanionChat', 'CodeCompanion' },
    cond = false,
    opts = {
      extensions = {
        mcphub = {
          enabled = mcphub_enabled,
          callback = "mcphub.extensions.codecompanion",
          opts = {
            -- MCP Tools
            make_tools = true,                    -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
            show_server_tools_in_chat = true,     -- Show individual tools in chat completion (when make_tools=true)
            add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
            show_result_in_chat = true,           -- Show tool results directly in chat buffer
            format_tool = nil,                    -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
            shutdown_delay = 60 * 1000,
            -- MCP Resources
            make_vars = true,           -- Convert MCP resources to #variables for prompts
            -- MCP Prompts
            make_slash_commands = true, -- Add MCP prompts as /slash commands
          }
        }
      },
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
}
