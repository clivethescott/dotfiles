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
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
    gitbrowse = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = {
      enabled = true,
      level = vim.log.levels.WARN,
    },
    quickfile = { enabled = true },
    scratch = { enabled = true, },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    toggle = { enabled = true },
    terminal = { enabled = true },
  },
  keys = {
    { "<space>gs", function() require 'snacks'.lazygit() end,   desc = "Lazygit" },
    { "<space>gh", function() require 'snacks'.gitbrowse() end, desc = "Open in Github" },
    {
      "<space>no",
      function() require 'snacks'.notifier.show_history() end,
      desc = "Notifications"
    },
    { "<leader>s", function() require 'snacks'.scratch() end,        desc = "Toggle Scratch Buffer" },
    { "<leader>S", function() require 'snacks'.scratch.select() end, desc = "Select Scratch Buffer" },
  },
  init = function()
    vim.keymap.set({ 'n', 'i', 'v' }, '<c-t>',
      function()
        require 'snacks'.terminal.toggle(nil, { win = { position = 'float' } })
      end,
      { desc = "Open Terminal" })
    vim.keymap.set('t', '<c-t>', '<cmd>close<cr>', { desc = 'Hide Terminal' })

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          require 'snacks'.debug.inspect(...)
        end
        _G.bt = function()
          require 'snacks'.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        require 'snacks'.toggle.inlay_hints():map("<space>sh")
        require 'snacks'.toggle.dim():map("<space>sd")
        -- Snacks.dim()
      end,
    })
  end,
}
