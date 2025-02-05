---@diagnostic disable: missing-fields
---@diagnostic disable-next-line: param-type-mismatch
local plugins_dir   = vim.fs.joinpath(vim.fn.stdpath('data'), '/lazy')
local conf_dir      = '~/.config/nvim'

---@type snacks.picker.layout.Config
local picker_layout = {
  reverse = true,
  ui_select = true,
  preview = false,
  layout = {
    box = "horizontal",
    backdrop = false,
    width = 0.95,
    height = 0.85,
    border = "none",
    {
      box = "vertical",
      { win = "list",  title_pos = "center", border = "rounded" },
      { win = "input", height = 1,               border = "rounded",   title = "{title} {live} {flags}", title_pos = "center" },
    },
    {
      win = "preview",
      title = "{preview:Preview}",
      width = 0.45,
      border = "rounded",
      title_pos = "center",
    },
  },
}

---@type snacks.picker.Config
local picker_config = {
  enabled = vim.g.use_picker == 'snacks.picker',
  win = {
    input = {
      keys = {
        ["<a-i>"] = { "toggle_preview", mode = { "i", "n" } },
        ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
        ["<c-s>"] = { "edit_split", mode = { "i", "n" } },
        ["<c-q>"] = { "qflist", mode = { "i", "n" } },
        ["<a-g>"] = { "toggle_ignored", mode = { "i", "n" } },
        ["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
        ["/"] = "toggle_focus",
      },
    },
  },
  formatters = {
    file = {
      filename_first = true,
      truncate = 80,
    },
  },
  layout = picker_layout,
}

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
    picker = picker_config,
    quickfile = { enabled = true },
    scratch = { enabled = true, },
    scroll = { enabled = false }, -- issues in search + position when switching buffers
    statuscolumn = { enabled = true },
    toggle = { enabled = true },
    terminal = { enabled = true },
  },
  keys = {
    { "gs",        function() require 'snacks'.lazygit() end,        desc = "Lazygit" },
    { "<space>gl", function() Snacks.picker.git_log_line() end,      desc = "Line Commits" },
    { "<space>gL", function() Snacks.picker.git_log_file() end,      desc = "Buffer Commits" },
    { "<space>gh", function() require 'snacks'.gitbrowse() end,      desc = "Open in Github" },
    { "<space>gb", function() require 'snacks'.git.blame_line() end, desc = "Blame line" },
    {
      "<space>sn",
      ---@diagnostic disable-next-line: undefined-field
      function() Snacks.picker.notifications() end,
      desc = "Notifications"
    },
    { "<space>sb",  function() Snacks.scratch() end,                     desc = "Toggle Scratch Buffer" },
    { "<space>sB",  function() Snacks.scratch.select() end,              desc = "Select Scratch Buffer" },
    { "<space>sp",  function() Snacks.picker() end,                      desc = "Pickers" },
    { "<space>sf",  function() Snacks.picker.explorer() end,             desc = "Explorer" },
    { "<space>sgd", function() Snacks.picker.git_status() end,           desc = "Git Status" },
    { "<space>sgs", function() Snacks.picker.git_branches() end,         desc = "Git Branches" },
    { "<space>sgl", function() Snacks.picker.git_log_line() end,         desc = "Line Commits" },
    { "<space>sgL", function() Snacks.picker.git_log_file() end,         desc = "Buffer Commits" },
    ---@diagnostic disable-next-line: undefined-field
    { "<c-p>",      function() Snacks.picker.files() end,                desc = "Files" },
    { "<c-e>",      function() Snacks.picker.buffers() end,              desc = "Buffers" },
    { "<space>tf",  function() Snacks.picker.grep() end,                 desc = "Grep" },
    { "<space>tF",  function() Snacks.picker.grep_word() end,            desc = "Grep selection or word", mode = { "n", "x" } },
    { "<space>to",  function() Snacks.picker.smart() end,                desc = "Recent Files" },
    { "<space>tq",  function() Snacks.picker.qflist() end,               desc = "Quickfix List" },
    { "<space>tl",  function() Snacks.picker.resume() end,               desc = "Resume" },
    { "<space>tc",  function() Snacks.picker.commands() end,             desc = "Commands" },
    { "<space>tC",  function() Snacks.picker.command_history() end,      desc = "Command history" },
    { "<space>th",  function() Snacks.picker.help() end,                 desc = "Help tags" },
    { "<space>tm",  function() Snacks.picker.marks() end,                desc = "Marks" },
    { "<space>tj",  function() Snacks.picker.jumps() end,                desc = "Jumps" },
    ---@diagnostic disable-next-line: undefined-field
    { "<space>tu",  function() Snacks.picker.undo() end,                 desc = "Undo" },
    { "<space>tr",  function() Snacks.picker.registers() end,            desc = "Registers" },
    { "<space>tb",  function() Snacks.picker.lines() end,                desc = "Buffer lines" },
    -- { "<space>lm",  function() Snacks.picker.lsp_definitions() end,      desc = "Goto Definition" },
    { "<space>lD",  function() Snacks.picker.diagnostics() end,          desc = "Snacks Diagnostics" },
    { "<space>lR",  function() Snacks.picker.lsp_references() end,       nowait = true,                   desc = "References" },
    { "<space>lI",  function() Snacks.picker.lsp_implementations() end,  desc = "Goto Implementation" },
    { "<space>ly",  function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<space>lw",  function() Snacks.picker.lsp_symbols() end,          desc = "LSP Symbols" },
    {
      "<leader>2",
      function() Snacks.picker.files { dirs = { conf_dir } } end,
      desc = "Config files"
    },
    {
      "<leader>5",
      function() Snacks.picker.grep { dirs = { plugins_dir } } end,
      desc = "Plugin files"
    },
    {
      "<leader>3",
      function() Snacks.picker.grep { dirs = { conf_dir } } end,
      desc = "Grep config"
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
