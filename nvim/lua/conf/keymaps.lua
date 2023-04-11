local default_opts = { silent = true, noremap = true }
local map = function(mode, lhs, rhs, opts)
  if opts then
    vim.tbl_extend('keep', opts, default_opts)
  else
    opts = default_opts
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Dealing with word wrap on long lines
map('n', 'k', [[v:count < 2 ? 'gk' : "m'" .. v:count .. 'k']], { expr = true })
map('n', 'j', [[v:count < 2 ? 'gj' : "m'" .. v:count .. 'j']], { expr = true })

-- Center search result
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', '#', '#zz')
map('n', '*', '*zz')

-- Open URI under cursor
local open_uri = function()
  require 'helper.utils'.open_uri()
end

-- Split movements
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')

-- Resize v-splits
map('n', '<space>wh', '5<c-w><')
map('n', '<space>wk', '5<c-w>+')
map('n', '<space>wl', '5<c-w>>')
map('n', '<space>wj', '5<c-w>-')

-- Saving
map('n', '<c-s>', ':w<cr>')
map('i', '<c-s>', '<esc>:w<cr>')

-- Jump to exact mark position either way
-- Disabled not recognised by which-key
-- map('n', "'", "`")

-- Faster way to quit
map('n', 'Q', ':q<cr>')

-- Faster way to yank line
map('n', 'Y', 'yy')

-- Shouldn't be using these anyway
map('n', '<left>', '<nop>')
map('v', '<left>', '<nop>')
map('n', '<right>', '<nop>')
map('v', '<right>', '<nop>')
map('n', '<down>', '<nop>')
map('v', '<down>', '<nop>')
map('n', '<up>', '<nop>')
map('v', '<up>', '<nop>')

-- Keep selection after visual indent/outdent
map('v', '<', '<gv')
map('v', '>', '>gv')

local toggle_winbar = function()
  if vim.o.winbar == "" then
    vim.o.winbar = "%{%v:lua.require'helper.utils'.nvim_winbar()%}"
  else
    vim.o.winbar = ""
  end
end

-- Quickly add empty lines
-- https://github.com/mhinz/vim-galore#quickly-add-empty-lines=
map('n', '<space>[', ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[")
map('n', '<space>]', ':<c-u>put =repeat(nr2char(10), v:count1)<cr>')

-- Telescope mappings
local telescope = require('telescope.builtin')
local telescope_extras = require('plug.telescope-extras')
map('n', '<c-e>', telescope.buffers)
-- Use git_files if in git dir, else use find_files
map('n', '<c-p>', telescope_extras.project_files)
local find_files = function()
  telescope.find_files {
    cwd = '~/.config/nvim'
  }
end
map('n', '<leader>2', find_files)
local grep_config_files = function()
  telescope.live_grep {
    cwd = '~/.config/nvim/lua'
  }
end
map('n', '<leader>3', grep_config_files)
local grep_zsh_files = function()
  telescope.find_files {
    cwd = '~/.config/zsh'
  }
end
map('n', '<leader>4', grep_zsh_files)

-- Metals mappings
local metals = require 'metals'
local tvp = require 'metals.tvp'

-- DAP mappings
local dap = require('dap')
local dap_commands = function()
  require 'telescope'.extensions.dap.commands {}
end
local dap_terminate = function()
  dap.terminate({}, {})
end
local dap_cond_breakpoint = function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end
local dap_list_breakpoints = function()
  require 'telescope'.extensions.dap.list_breakpoints {}
end
local show_dap_ui = function()
  local ok, dapui = pcall(require, 'dapui')
  if not ok then
    return
  end
  dapui.eval('', {})
end
local go_debug_test = function()
  local ok, dap_go = pcall(require, 'dap-go')
  if not ok then
    return
  end
  dap_go.debug_test()
end

-- Zen Mode Mappings
local zen_mode = function()
  require('zen-mode').toggle({
    window = {
      width = .85 -- width will be 85% of the editor width
    }
  })
end

-- Luasnip Mappings
local luasnip = require('luasnip')
map({ 'i', 's' }, '<Tab>', function()
  if luasnip.expand_or_jumpable() then
    luasnip.jump(1)
  else
    return '<Tab>'
  end
end, { expr = true })
map({ 'i', 's' }, '<S-Tab>', function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    return '<S-Tab>'
  end
end, { expr = true })
-- minimal choice change, same as when using vim.ui.select below
map({ 'i' }, '<C-y>', function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end)
-- Luasnip choice selection using vim.ui.select
map({ 'i' }, '<C-u>', function()
  if luasnip.get_active_snip() then
    require('luasnip.extras.select_choice')()
  end
end)
local edit_snippets = function()
  require("luasnip.loaders.from_lua").edit_snippet_files()
end

local prev_todo = function()
  require 'todo-comments'.jump_prev()
end
local next_todo = function()
  require 'todo-comments'.jump_next()
end

local wk = require 'which-key'
wk.register({
  ["["] = {
    name = '+Previous',
    t = { prev_todo, 'TODO' },
    q = { "<cmd>cprevious<cr>", 'Quickfix Entry' },
    Q = { "<cmd>cNfile<cr>", 'Quickfix Entry in last file' },
  },
  ["]"] = {
    name = '+Next',
    t = { next_todo, 'TODO' },
    q = { "<cmd>cnext<cr>", 'Quickfix Entry' },
    Q = { "<cmd>cnfile<cr>", 'Quickfix Entry in next file' },
  },
  ["<space>"] = {
    ['['] = { ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[", 'Add blank line above' },
    [']'] = { ":<c-u>put =repeat(nr2char(10), v:count1)<cr>", 'Add blank line below' },
    d = {
      name = '+DAP',
      b = { dap.toggle_breakpoint, 'Toggle Breakpoint' },
      B = { dap_cond_breakpoint, 'Conditional Breakpoint' },
      c = { dap_commands, 'Commands' },
      d = { dap.repl.toggle, 'Toggle REPL' },
      e = { show_dap_ui, 'Show DAP UI' },
      i = { dap.step_into, 'Step In' },
      I = { dap.step_out, 'Step Out' },
      l = { dap_list_breakpoints, 'List Breakpoints' },
      L = { dap.clear_breakpoints, 'Clear Breakpoints' },
      o = { dap.step_over, 'Step Over' },
      q = { dap_terminate, 'Terminate' },
      r = { dap.continue, 'Continue' },
      t = { go_debug_test, 'Debug Go Test' },
      x = { dap_terminate, 'Terminate' },
    },
    e = {
      name = '+Trouble Diagnostics',
      d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'Buffer Diagnostics' },
      e = { '<cmd>TroubleToggle<cr>', 'Toggle Window' },
      l = { '<cmd>TroubleToggle loclist<cr>', 'Location List' },
      q = { '<cmd>TroubleToggle quickfix<cr>', 'Quickfix List' },
      r = { '<cmd>TroubleToggle lsp_references<cr>', 'LSP References' },
      t = { '<cmd>TodoTrouble<cr>', 'TODOs' },
      w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Workspace Diagnostics' },
    },
    g = {
      '+Git',
      g = { '<cmd>Telescope git_branches<cr>', 'Branches' },
      h = { '<cmd>DiffviewFileHistory<cr>', 'File History' },
      l = { '<cmd>Telescope git_bcommits<cr>', 'Buffer Commits' },
      L = { '<cmd>Telescope git_commits<cr>', 'All Commits' },
      s = { '<cmd>Telescope git_status<cr>', 'Status + diff' },
    },
    m = {
      name = '+Metals',
      c = { require 'telescope'.extensions.metals.commands, 'Commands' },
      d = { metals.goto_super_method, 'Go To Super Method' },
      n = { metals.new_scala_file, 'New Scala File' },
      o = { metals.hover_worksheet, 'Hover Worksheet' },
      s = { metals.switch_bsp, 'Switch BSP Server' },
      t = {
        name = 'TVP',
        o = { tvp.reveal_in_tree, 'Reveal In Tree' },
        t = { tvp.toggle_tree_view, 'Toggle Tree' },
      },
    },
    o = {
      name = '+Open Window',
      d = { '<cmd>DiffviewOpen<cr>', 'Diffview' },
      f = { toggle_winbar, 'Winbar' },
      l = { '<cmd>Lazy<cr>', 'Plugin Mgr' },
      m = { '<cmd>Mason<cr>', 'LSP Server Mgr' },
      t = { '<cmd>NvimTreeToggle<cr>', 'NvimTree' },
      u = { '<cmd>UndotreeToggle<cr>', 'UndoTree' },
      z = { zen_mode, 'Toggle Zen Mode' }
    },
    t = {
      name = '+Telescope',
      c = { '<cmd>Telescope commands<cr>', 'Commands' },
      f = { '<cmd>Telescope live_grep<cr>', 'Live grep' },
      F = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Buffer fuzzy find' },
      g = { '<cmd>Telescope file_browser<cr>', 'Open FileBrowser in root dir' },
      G = { '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>', 'Open FileBrowser in buffer dir' },
      h = { '<cmd>Telescope help_tags<cr>', 'Help tags' },
      j = { '<cmd>Telescope jumplist<cr>', 'Jump list' },
      k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
      l = { '<cmd>Telescope resume<cr>', 'Resume last picker' },
      m = { '<cmd>Telescope marks<cr>', 'Marks' },
      o = { '<cmd>Telescope oldfiles<cr>', 'Old Files' },
      q = { '<cmd>Telescope quickfix<cr>', 'Quickfix List' },
      r = { '<cmd>Telescope registers<cr>', 'Registers' },
      t = { '<cmd>TodoTelescope<cr>', 'TODOs' },
    },
    w = {
      name = '+Resize Splits',
      h = { '5<c-w><', 'Resize left' },
      l = { '5<c-w>>', 'Resize right' },
      j = { '5<c-w>-', 'Resize down' },
      k = { '5<c-w>+', 'Resize up' },
    }
  },
  ["<leader>"] = {
    ['1'] = { '<cmd>NvimTreeToggle<cr>', 'Toggle NvimTree' },
    ['!'] = { '<cmd>NvimTreeFindFile!<cr>', 'Find current file in NvimTree' },
    ['2'] = { find_files, 'Find nvim config files' },
    ['3'] = { grep_config_files, 'Live grep nvim config files' },
    ['4'] = { grep_zsh_files, 'Find zsh config files' },
    g = {
      name = '+GoTo',
      f = { '<cmd>AlternateFile<cr>', 'Alternate file' },
      i = { '<cmd>GoImports<cr>', 'Go Imports' },
      x = { open_uri, 'URI at cursor' },
    },
    m = { '<cmd>silent! nohls<cr>', 'Clear search highlight' },
    s = { edit_snippets, 'Edit LuaSnippets' },
  },
  ['gp'] = { ':b#<cr>', 'Alternate buffer' },
})
