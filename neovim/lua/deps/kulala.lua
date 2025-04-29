local fts = { "http", "rest" }

local switch_env = function()
  local envs = { 'dev', 'qa', 'prod' }
  local current_env = require'kulala'.get_selected_env() or ''
  local change_env = vim.tbl_filter(function(env) return env ~= current_env end, envs)
  vim.ui.select(change_env, {
    prompt = 'Switch environment:[' .. current_env .. ']'
  }, function(choice)
    if choice ~= nil then
      require('kulala').set_selected_env(choice)
    end
  end)
end

return {
  'mistweaverco/kulala.nvim',
  -- keys = {"<leader>Rs", "<leader>Ra", "<leader>Ro"},
  ft = { "http", "rest" },
  opts = {
    global_keymaps = {
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
      ["Select environment"] = { "<space>he", switch_env, ft = fts },
      ["Clear globals"] = { "<space>hC", function() require("kulala").scripts_clear_global() end, ft = fts },

      ["Find request"] = { "<space>hs", function() require("kulala").search() end, ft = { "http", "rest" }, },
      ["Inspect current request"] = { "<space>hi", function() require("kulala").inspect() end, ft = fts },
    },
    kulala_keymaps = true,
    default_env = 'dev',
    request_timeout = 5000,
    -- Current available pane contains { "body", "headers", "headers_body", "script_output", "stats", "verbose" },
    default_winbar_panes = { 'body', 'headers' },
    default_view = 'headers_body',
  },
}
