local plugins_dir = vim.fs.joinpath(vim.fn.stdpath('data'), '/lazy')

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
    picker = {
      enabled = true,
      layout = {
        ui_select = true,
      }
    },
  },
  keys = {
    { "gs",        function() require 'snacks'.lazygit() end,        desc = "Lazygit" },
    { "<space>gl", function() require 'snacks'.lazygit() end,        desc = "Lazygit" },
    { "<space>gh", function() require 'snacks'.gitbrowse() end,      desc = "Open in Github" },
    { "<space>gb", function() require 'snacks'.git.blame_line() end, desc = "Blame line" },
    {
      "<space>sn",
      function() require 'snacks'.picker.notifications() end,
      desc = "Notifications"
    },
    { "<space>sb",  function() require 'snacks'.scratch() end,           desc = "Toggle Scratch Buffer" },
    { "<space>sB",  function() require 'snacks'.scratch.select() end,    desc = "Select Scratch Buffer" },
    { "<space>sp",  function() require 'snacks'.picker() end,            desc = "Pickers" },
    { "<space>sgd",  function() require 'snacks'.picker.git_status() end, desc = "Git Status" },
    { "<space>sgs",  function() require 'snacks'.picker.git_branches() end, desc = "Git Branches" },
    { "<space>sgl",  function() require 'snacks'.picker.git_log_file() end, desc = "Buffer Commits" },
    { "<c-p>",      function() require 'snacks'.picker.smart() end,      desc = "Files + Buffers" },
    { "<c-e>",      function() require 'snacks'.picker.buffers() end,    desc = "Buffers" },
    { "<space>tf",  function() require 'snacks'.picker.grep() end,       desc = "Grep" },
    { "<space>tF",  function() Snacks.picker.grep_word() end,            desc = "Grep selection or word", mode = { "n", "x" } },
    { "<space>to",  function() Snacks.picker.recent() end,               desc = "Recent Files" },
    { "<space>tq",  function() Snacks.picker.qflist() end,               desc = "Quickfix List" },
    { "<space>tl",  function() Snacks.picker.resume() end,               desc = "Resume" },
    { "<space>tc",  function() Snacks.picker.commands() end,             desc = "Commands" },
    { "<space>th",  function() Snacks.picker.help() end,                 desc = "Help tags" },
    { "<space>tm",  function() Snacks.picker.marks() end,                desc = "Marks" },
    { "<space>tj",  function() Snacks.picker.jumps() end,                desc = "Jumps" },
    { "<space>tu",  function() Snacks.picker.undo() end,                desc = "Undo" },
    { "<space>tr",  function() Snacks.picker.registers() end,            desc = "Registers" },
    { "<space>tb",  function() Snacks.picker.lines() end,                desc = "Buffer lines" },
    -- { "<space>lm",  function() Snacks.picker.lsp_definitions() end,      desc = "Goto Definition" },
    { "<space>ld",  function() Snacks.picker.diagnostics() end,          desc = "Diagnostics" },
    { "<space>lR",  function() Snacks.picker.lsp_references() end,       nowait = true,                   desc = "References" },
    { "<space>lI",  function() Snacks.picker.lsp_implementations() end,  desc = "Goto Implementation" },
    { "<space>ly",  function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<leader>lw", function() Snacks.picker.lsp_symbols() end,          desc = "LSP Symbols" },
    {
      "<leader>2",
      function()
        require 'snacks'.picker.files {
          dirs = { '~/.config/neovim' }
        }
      end,
      desc = "Nvim config"
    },
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
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        Snacks.toggle.inlay_hints():map("<space>sti")
        Snacks.toggle.dim():map("<space>std")
        Snacks.toggle.option("conceallevel",
          { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<space>stc")
        -- Snacks.dim()
      end,
    })
  end,
}
