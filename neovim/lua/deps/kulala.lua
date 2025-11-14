local fts = { "http", "rest" }

return {
  'mistweaverco/kulala.nvim',
  ft = { "http", "rest" },
  opts = {
    lsp = {
      formatter = true, -- needed for import openAPI/postman
    },
    global_keymaps = {
      ["Send request"] = false,
      ["Open scratchpad"] = {
        "<space>hb",
        function() require("kulala").scratchpad() end,
        mode = { "n", "v" },
        ft = fts,
      },
      ["Send request <cr>"] = { -- sets global mapping
        "<space>hr",
        function() require("kulala").run() end,
        mode = { "n", "v" },
        ft = fts,
      },
      ["Send all requests"] = {
        "<space>ha",
        function() require("kulala").run_all() end,
        mode = { "n", "v" },
        ft = fts,
      },
      ["Replay the last request"] = {
        "<space>hl",
        function() require("kulala").replay() end,
        ft = fts,
      },
      ["Open kulala"] = { "<space>ho", function() require("kulala").open() end, ft = fts },
      ["Toggle headers/body"] = {
        "<space>ht",
        function() require("kulala").toggle_view() end,
        ft = fts,
      },
      ["Copy as cURL"] = { "<space>hc", function() require("kulala").copy() end, ft = fts },
      ["Paste from curl"] = { "<space>hp", function() require("kulala").from_curl() end, ft = fts },
      ["Select environment"] = { "<space>he", function() require 'kulala'.set_selected_env() end, ft = fts },
      ["Manage Auth Config"] = { "<space>hz", function() require("kulala.ui.auth_manager").open_auth_config() end, ft = { "http", "rest" }, },
      ["Clear globals"] = { "<space>hC", function() require("kulala").scripts_clear_global() end, ft = fts },

      ["Find request"] = { "<space>hs", function() require("kulala").search() end, ft = { "http", "rest" }, },
      ["Inspect current request"] = { "<space>hi", function() require("kulala").inspect() end, ft = fts },
    },
    kulala_keymaps = true,
    default_env = 'qa',
    request_timeout = 5000,
    -- Current available pane contains { "body", "headers", "headers_body", "script_output", "stats", "verbose" },
    -- default_winbar_panes = { 'body', 'headers' },
    default_winbar_panes = { 'body' },
    default_view = 'headers_body',
  },
  keys = {
    {
      "<space>hE",
      function()
        local config_path = vim.fs.joinpath(vim.env.HOME, 'Code/HTTP/http-client.env.json')
        vim.cmd('e ' .. config_path)
      end,
      desc = "Open Kulala environments",
      ft = 'http',
    },
    {
      "<space>hi", -- https://neovim.getkulala.net/docs/usage/import-export#importing
      function() require("kulala").import() end,
      desc = "Import from postman/openapi",
      ft = { 'json', 'yaml', 'bruno' }
    }
  }
}
