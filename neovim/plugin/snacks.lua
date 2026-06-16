if vim.g.use_picker ~= 'snacks.picker' then return end

---@diagnostic disable: missing-fields
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath('data'), '/lazy')
local conf_dirs   = { '~/.config/nvim', '~/.config/wezterm',
  '~/.config/atuin', '~/.config/lazygit', '~/.config/ghostty' }

vim.pack.add({ { src = 'https://github.com/folke/snacks.nvim' } })

vim.schedule(function()
  local Snacks = require'snacks'

  ---@type snacks.Config
  Snacks.setup({
    statuscolumn = { enabled = true },
    ---@type snacks.picker.Config
    picker = {
      enabled = vim.g.use_picker == 'snacks.picker',
      win = {
        input = {
          keys = {
            ["<a-i>"] = { "toggle_preview", mode = { "i", "n" } },
            ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
            ["<c-s>"] = { "edit_split", mode = { "i", "n" } },
            ["<c-t>"] = { "edit_tab", mode = { "i", "n" } },
            ["<c-q>"] = { "qflist", mode = { "i", "n" } },
            ["<a-g>"] = { "toggle_ignored", mode = { "i", "n" } },
            ["<a-m>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<a-f>"] = { "toggle_maximize", mode = { "i", "n" } },
            ["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
            ["<M-Down>"] = { "history_forward", mode = { "i", "n" } },
            ["<M-Up>"] = { "history_back", mode = { "i", "n" } },
            ["<a-r>"] = { "toggle_regex", mode = { "i", "n" } },
          },
        },
      },
      formatters = {
        file = {
          filename_first = true,
          truncate = 80,
        },
      },
      layout = { hidden = { "preview" }, fullscreen = false },
      ui_select = true,
    },
  })

  vim.keymap.set('n', '<c-p>', function() Snacks.picker.files() end, { silent = true, desc = "Files" })
  vim.keymap.set('n', '<M-p>', function() Snacks.picker.files { cwd = vim.fn.expand('%:p:h') } end, { silent = true, desc = "Files (lwd)" })
  vim.keymap.set('n', '<c-e>', function() Snacks.picker.buffers() end, { silent = true, desc = "Buffers" })
  vim.keymap.set('n', '<space>tf', function() Snacks.picker.grep() end, { silent = true, desc = "Live grep" })
  vim.keymap.set('n', '<space>tF', function() Snacks.picker.grep_word() end, { silent = true, desc = "Grep cword" })
  vim.keymap.set('n', '<space>to', function() Snacks.picker.recent() end, { silent = true, desc = "Recent Files" })
  vim.keymap.set('n', '<space>tq', function() Snacks.picker.qflist() end, { silent = true, desc = "Quickfix" })
  vim.keymap.set('n', '<space>tl', function() Snacks.picker.resume() end, { silent = true, desc = "Resume" })
  vim.keymap.set('n', '<space>tc', function() Snacks.picker.commands() end, { silent = true, desc = "Commands" })
  vim.keymap.set('n', '<space>tC', function() Snacks.picker.command_history() end, { silent = true, desc = "Commands History" })
  vim.keymap.set('n', '<space>th', function() Snacks.picker.help() end, { silent = true, desc = "Helptags" })
  vim.keymap.set('n', '<space>tH', function() Snacks.picker.highlights() end, { silent = true, desc = "Highlights" })
  vim.keymap.set('n', '<space>tm', function() Snacks.picker.marks() end, { silent = true, desc = "Marks" })
  vim.keymap.set('n', '<space>tz', function() Snacks.picker.zoxide() end, { silent = true, desc = "Zoxide" })
  vim.keymap.set('n', '<space>tt', function() Snacks.picker() end, { silent = true, desc = "Tagstack" })
  vim.keymap.set('n', '<space>tr', function() Snacks.picker.registers() end, { silent = true, desc = "Registers" })
  vim.keymap.set('n', '<space>tb', function() Snacks.picker.lines() end, { silent = true, desc = "Open Buffers lines" })
  vim.keymap.set('n', '<space>ld', function() Snacks.picker.diagnostics() end, { silent = true, desc = "Diagnostics" })
  vim.keymap.set('n', 'gR', function() Snacks.picker.lsp_references() end, { silent = true, desc = "LSP References" })
  vim.keymap.set('n', '<space>lI', function() Snacks.picker.lsp_implementations() end, { silent = true, desc = "LSP Implementations" })
  vim.keymap.set('n', '<space>lw', function() Snacks.picker.lsp_workspace_symbols() end, { silent = true, desc = "LSP workspace symbols" })
  vim.keymap.set('n', '<leader>z', function() Snacks.picker.spelling() end, { silent = true, desc = "Spell Suggest" })
  vim.keymap.set('n', '<leader>2',
    function() Snacks.picker.files { dirs = conf_dirs } end,
    { silent = true, desc = "Nvim files" })
  vim.keymap.set('n', '<leader>3',
    function() Snacks.picker.grep { dirs = conf_dirs } end,
    { silent = true, desc = "Nvim files" })
  vim.keymap.set('n', '<leader>4',
    function() Snacks.picker.files { dirs = { plugins_dir } } end,
    { silent = true, desc = "Nvim plugin files" })
  vim.keymap.set('n', '<leader>5',
    function() Snacks.picker.grep { dirs = { plugins_dir } } end,
    { silent = true, desc = "Nvim plugin grep" })
  vim.keymap.set('n', '<space>ho',
    function() Snacks.picker.files { cwd = '~/Code/HTTP' } end,
    { silent = true, desc = "HTTP files" })
end)
