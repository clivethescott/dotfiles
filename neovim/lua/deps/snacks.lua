return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dim = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Sessions", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
    gitbrowse = { enabled = true },
    git = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = {
      enabled = true,
      level = vim.log.levels.WARN,
    },
    quickfile = { enabled = true },
    scratch = { enabled = true, },
    scroll = { enabled = false }, -- issues in search + position when switching buffers
    statuscolumn = { enabled = true },
    toggle = { enabled = true },
    terminal = { enabled = true },
  },
  keys = {
    { "gs",        function() require 'snacks'.lazygit() end,        desc = "Lazygit" },
    { "<space>gl", function() require 'snacks'.lazygit() end,        desc = "Lazygit" },
    { "<space>gh", function() require 'snacks'.gitbrowse() end,      desc = "Open in Github" },
    { "<space>gb", function() require 'snacks'.git.blame_line() end, desc = "Blame line" },
    {
      "<space>sn",
      function() require 'snacks'.notifier.show_history() end,
      desc = "Notifications"
    },
    { "<space>sb", function() require 'snacks'.scratch() end,        desc = "Toggle Scratch Buffer" },
    { "<space>sB", function() require 'snacks'.scratch.select() end, desc = "Select Scratch Buffer" },
  },
  init = function()
    vim.keymap.set({ 'n', 'i', 'v' }, [[<M-\>]],
      function()
        require 'snacks'.terminal.toggle(nil, { win = { position = 'float' } })
      end,
      { desc = "Open Terminal" })
    vim.keymap.set('t', [[<M-\>]], '<cmd>close<cr>', { desc = 'Hide Terminal' })

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        local Snacks = require 'snacks'
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        -- vim.print = _G.dd -- Override print to use snacks for `:=` command

        Snacks.toggle.inlay_hints():map("<space>sti")
        Snacks.toggle.dim():map("<space>std")
        Snacks.toggle.option("conceallevel",
          { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<space>stc")
        -- Snacks.dim()
      end,
    })
  end,
}
