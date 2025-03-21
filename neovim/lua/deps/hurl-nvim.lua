local switch_env = function()
  local envs = { 'dev', 'qa', 'prod' }
  local current_env = vim.g.http_env or ''
  local change_env = vim.tbl_filter(function(env) return env ~= current_env end, envs)
  vim.ui.select(change_env, {
    prompt = 'Switch environment:[' .. current_env .. ']'
  }, function(choice)
    if choice ~= nil then
      vim.cmd('HurlSetEnvFile ' .. choice .. '.env')
      vim.g.http_env = choice
    end
  end)
end
return {
  "jellydn/hurl.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = "hurl",
  cond = false,
  opts = {
    debug = true,
    auto_close = false,
    show_notification = false,
    mode = "split",
    formatters = {
      json = { 'jq' },
    },
    -- Default mappings for the response popup or split views
    mappings = {
      close = 'q',          -- Close the response popup or split view
      next_panel = '<C-n>', -- Move to the next response popup window
      prev_panel = '<C-p>', -- Move to the previous response popup window
    },
    env_file = {
      'dev.env',
    },
  },
  keys = {
    { "<space>ha", "<cmd>HurlRunner<CR>",       desc = "Run All requests" },
    { "<space>hr", "<cmd>HurlRunnerAt<CR>",     desc = "Run Current",          mode = "n" },
    { "<space>hv", ":HurlRunner<CR>",           desc = "Run Current",          mode = "v" },
    { "<space>hR", "<cmd>HurlVerbose<CR>",      desc = "Run Current (verbose)" },
    { "<space>he", function() switch_env() end, desc = "Switch env" },
    -- { "<space>re", "<cmd>HurlManageVariable<CR>",     desc = "Show Environment" },
    -- { "<leader>te", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
    -- { "<leader>tE", "<cmd>HurlRunnerToEnd<CR>", desc = "Run Api request from current entry to end" },
    -- { "<leader>tm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
    -- { "<leader>tv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
    -- { "<leader>tV", "<cmd>HurlVeryVerbose<CR>", desc = "Run Api in very verbose mode" },
  },
}
