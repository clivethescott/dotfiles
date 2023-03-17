local map = function(mode, lhs, rhs, opts)
  opts = opts or { silent = true, noremap = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

local opts = { silent = true, noremap = true }

-- Dealing with word wrap on long lines
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })

-- Center search result
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', '#', '#zz')
map('n', '*', '*zz')

-- Remove search highlight
-- map('n', '<leader>m', ':silent! nohls<cr>') -- defined in which-key

-- Alternate buffer
map('n', 'gp', ':b#<cr>')

-- Open URI under cursor
local open_uri = function()
  require 'helper.utils'.open_uri()
end
map('n', 'gx', open_uri)

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
map('n', '<space>f', toggle_winbar)

-- Quickly add empty lines
-- https://github.com/mhinz/vim-galore#quickly-add-empty-lines=
vim.api.nvim_set_keymap('n', '<space>[', ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[", opts)
vim.api.nvim_set_keymap('n', '<space>]', ':<c-u>put =repeat(nr2char(10), v:count1)<cr>', opts)

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

vim.api.nvim_set_keymap('n', '<leader>gt', '<cmd>AlternateFile<cr>', opts)
local open_file_browser = function(fopts)
  fopts = fopts or {}
  require 'telescope'.extensions.file_browser.file_browser(fopts)
end

map('n', '<leader>to', open_file_browser)
map('n', '<leader>tO', function()
  local fopts = {
    select_buffer = true,
    path = vim.fn.expand('%:p:h')
  }
  open_file_browser(fopts)
end)
-- map('n', '<leader>t', telescope.builtin)
map('n', '<leader>tl', telescope.resume)
map('n', '<leader>tf', telescope.current_buffer_fuzzy_find)
map('n', '<c-t>', telescope.current_buffer_fuzzy_find)
map('n', '<c-f>', telescope.live_grep)
map('n', '<leader>tF', telescope.live_grep)
map('n', '<leader>tc', telescope.commands)
map('n', '<leader>tm', telescope.marks)
map('n', '<leader>tj', telescope.jumplist)
map('n', '<leader>tr', telescope.registers)
map('n', '<leader>tk', telescope.keymaps)
map('n', '<leader>th', telescope.help_tags)
map('n', '<leader>go', telescope.oldfiles)
-- map('n', '<space>fs', telescope.spell_suggest)
map('n', '<leader>gc', telescope.git_commits)
map('n', '<leader>gC', telescope.git_bcommits)
map('n', '<leader>gb', telescope.git_branches)
map('n', '<leader>gs', telescope.git_status)
-- map('n', '<space>ts', telescope.treesitter)
-- map('n', '<leader>st', telescope.tags)
-- map('n', '<space>fs', telescope.grep_string)
-- map('n', '<leader>so', function()
--   telescope.tags { only_current_buffer = true }
-- end)

-- Metals mappings
local metals = require 'metals'
local tvp = require 'metals.tvp'
map('n', '<space>to', tvp.reveal_in_tree)
map('n', '<space>tt', tvp.toggle_tree_view)

-- DAP mappings
local dap = require('dap')
map('n', '<space>db', dap.toggle_breakpoint)
local dap_cond_breakpoint = function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end
map('n', '<space>dB', dap_cond_breakpoint)
local dap_list_breakpoints = function()
  require 'telescope'.extensions.dap.list_breakpoints {}
end
map('n', '<space>dl', dap_list_breakpoints)
map('n', '<space>dL', dap.clear_breakpoints)
local dap_commands = function()
  require 'telescope'.extensions.dap.commands {}
end
map('n', '<space>dc', dap_commands)
map('n', '<space>dr', dap.continue)
map('n', '<F5>', dap.continue)
-- map('n', '<space>dc', dap.run_to_cursor)
map('n', '<F8>', dap.step_over)
map('n', '<space>do', dap.step_over)
map('n', '<space>di', dap.step_into)
map('n', '<space>dI', dap.step_out)
map('n', '<space>dd', dap.repl.toggle)
-- map('n', '<space>dr', dap.run_last)
local dap_terminate = function()
  dap.terminate({}, {})
end
map('n', '<space>dq', dap_terminate)
map('n', '<space>dx', dap_terminate)
local show_dap_ui = function()
  local ok, dapui = pcall(require, 'dapui')
  if not ok then
    return
  end
  dapui.eval('', {})
end
map({ 'n', 'v' }, '<space>de', show_dap_ui)
local go_debug_test = function()
  local ok, dap_go = pcall(require, 'dap-go')
  if not ok then
    return
  end
  dap_go.debug_test()
end
map('n', '<space>dt', go_debug_test)

-- Trouble Mappings
vim.api.nvim_set_keymap('n', '<space>ee', '<cmd>TroubleToggle<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>ew', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>ed', '<cmd>TroubleToggle document_diagnostics<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>el', '<cmd>TroubleToggle loclist<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>eq', '<cmd>TroubleToggle quickfix<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>er', '<cmd>TroubleToggle lsp_references<cr>', opts)

-- NvimTree Mappings
vim.api.nvim_set_keymap('n', '<leader>!', '<cmd>NvimTreeFindFile!<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>1', '<cmd>NvimTreeToggle<cr>', opts)


-- Zen Mode Mappings
local zen_mode = function()
  require('zen-mode').toggle({
    window = {
      width = .85 -- width will be 85% of the editor width
    }
  })
end
map('n', '<leader>z', zen_mode)

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
map('n', '<leader>s', edit_snippets)

-- UndoTree
vim.api.nvim_set_keymap('n', '<space>u', '<cmd>UndotreeToggle<cr>', opts)


local wk = require 'which-key'
wk.register({
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
      w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Workspace Diagnostics' },
    },
    g = {
      '+Go',
      i = { '<cmd>GoImports<cr>', 'Go Imports' },
    },
    f = { toggle_winbar, 'Toggle winbar' },
    m = {
      name = '+Metals',
      c = { require 'telescope'.extensions.metals.commands, 'Commands' },
      d = { metals.goto_super_method, 'Go To Super Method' },
      o = { metals.hover_worksheet, 'Hover Worksheet' },
    },
    t = {
      name = 'TVP',
      o = { tvp.reveal_in_tree, 'Reveal In Tree' },
      t = { tvp.toggle_tree_view, 'Toggle Tree' },
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
    m = { '<cmd>silent! nohls<cr>', 'Clear search highlight' },
    g = {
      name = '+GoTo',
      b = { '<cmd>Telescope git_branches<cr>', 'Git branches' },
      c = { '<cmd>Telescope git_commits<cr>', 'Git commits' },
      C = { '<cmd>Telescope git_bcommits<cr>', 'Git Buffer commits' },
      o = { '<cmd>Telescope oldfiles<cr>', 'Old Files' },
      s = { '<cmd>Telescope git_status<cr>', 'Git status' },
      t = { '<cmd>AlternateFile<cr>', 'Alternate file' },
    },
    s = { edit_snippets, 'Edit Snippets' },
    t = {
      name = '+Telescope',
      c = { '<cmd>Telescope commands<cr>', 'Commands' },
      f = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Buffer fuzzy find' },
      F = { '<cmd>Telescope live_grep<cr>', 'Live grep' },
      h = { '<cmd>Telescope help_tags<cr>', 'Help tags' },
      j = { '<cmd>Telescope jump_list<cr>', 'Jump list' },
      k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
      l = { '<cmd>Telescope resume<cr>', 'Resume last picker' },
      m = { '<cmd>Telescope marks<cr>', 'Marks' },
      o = { '<cmd>Telescope file_browser<cr>', 'Open FileBrowser in root dir' },
      O = { '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>', 'Open FileBrowser in buffer dir' },
      r = { '<cmd>Telescope registers<cr>', 'Registers' },
    },
    z = { zen_mode, 'Toggle Zen Mode' }
  },
  g = {
    p = { ':b#<cr>', 'Alternate buffer' },
    x = { open_uri, 'Open URI at cursor' },
  },
})
