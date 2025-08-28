local adapter = vim.env.IS_WORK_PC == "true" and "copilot" or "copilot"
return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest",
    config = true,
  },
  {
    "olimorris/codecompanion.nvim",
    cmd = { 'CodeCompanionChat', 'CodeCompanion' },
    opts = {
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            -- MCP Tools
            make_tools = true,                -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
            show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
            add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
            show_result_in_chat = true,       -- Show tool results directly in chat buffer
            format_tool = nil,                -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
            -- MCP Resources
            make_vars = true,                 -- Convert MCP resources to #variables for prompts
            -- MCP Prompts
            make_slash_commands = true,       -- Add MCP prompts as /slash commands
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
