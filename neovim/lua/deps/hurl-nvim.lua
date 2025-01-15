local set_env = function(env)
  vim.g.hurl_env = env
  vim.cmd('HurlSetEnvFile ' .. env .. '.env')
end
return {
  "jellydn/hurl.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = "hurl",
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
    { "<space>ra", "<cmd>HurlRunner<CR>",             desc = "Run All requests" },
    { "<space>rr", "<cmd>HurlRunnerAt<CR>",           desc = "Run Current",          mode = "n" },
    { "<space>rv", ":HurlRunner<CR>",                 desc = "Run Current",          mode = "v" },
    { "<space>rR", "<cmd>HurlVerbose<CR>",            desc = "Run Current (verbose)" },
    { "<space>rd", "<cmd>HurlSetEnvFile dev.env<CR>", desc = "Switch to Dev env" },
    { "<space>rd", function() set_env("dev") end,     desc = "Switch to Dev env" },
    { "<space>rq", function() set_env("qa") end,      desc = "Switch to QA env" },
    { "<space>rp", function() set_env("prod") end,    desc = "Switch to Prod env" },
    { "<space>re", "<cmd>HurlManageVariable<CR>",     desc = "Show Environment" },
    -- { "<leader>te", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
    -- { "<leader>tE", "<cmd>HurlRunnerToEnd<CR>", desc = "Run Api request from current entry to end" },
    -- { "<leader>tm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
    -- { "<leader>tv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
    -- { "<leader>tV", "<cmd>HurlVeryVerbose<CR>", desc = "Run Api in very verbose mode" },
  },
}
