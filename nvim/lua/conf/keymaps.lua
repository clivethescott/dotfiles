local map = function(mode, lhs, rhs, opts)
  opts = opts or { silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

local opts = { silent = true, noremap = true }

-- Dealing with word wrap on long lines
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })

-- System clipboard copy/paste
map('v', '<space>y', '"*yi')
map({ 'n', 'v' }, '<space>p', '"*P')

-- Center search result
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', '#', '#zz')
map('n', '*', '*zz')

-- Remove search highlight
map('n', '<leader>m', ':silent! nohls<cr>')

-- Alternate buffer
map('n', 'gp', ':b#<cr>')

-- Open URI under cursor
map('n', 'gx', function()
  require 'helper.utils'.open_uri()
end)

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
map('n', "'", "`")

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

map('n', '<space>f', function()
  if vim.o.winbar == "" then
    vim.o.winbar = "%{%v:lua.require'helper.utils'.nvim_winbar()%}"
  else
    vim.o.winbar = ""
  end
end)

-- Use <c-p> and <c-n> to match command history by substring
-- Just like how <up> and <down> work
-- https://github.com/neovim/neovim/issues/20231
map('c', '<c-n>', [[wildmenumode() == 1 ? '<c-n>' : '<down>']], { expr = true, replace_keycodes = false })
map('c', '<c-n>', [[wildmenumode() == 1 ? '<c-p>' : '<up>']], { expr = true, replace_keycodes = false })

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
map('n', '<leader>2', function()
  telescope.find_files {
    cwd = '~/.config/nvim'
  }
end)
map('n', '<leader>3', function()
  telescope.live_grep {
    cwd = '~/.config/nvim/lua'
  }
end)
map('n', '<leader>4', function()
  telescope.find_files {
    cwd = '~/.config/zsh'
  }
end)

vim.api.nvim_set_keymap('n', '<leader>gt', '<cmd>AlternateFile<cr>', opts)

map('n', '<leader>t', telescope.builtin)
map('n', '<leader>tf', telescope.current_buffer_fuzzy_find)
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

-- NvimTree mappings
local tree = require('nvim-tree')
map('n', '<leader>1', tree.toggle)

-- Metals mappings
local metals = require 'metals'
local tvp = require 'metals.tvp'
map('n', '<space>wo', metals.hover_worksheet)
map('n', '<space>to', tvp.reveal_in_tree)
map('n', '<space>tt', tvp.toggle_tree_view)
map('n', 'gD', metals.goto_super_method)

-- DAP mappings
local dap = require('dap')
map('n', '<space>db', dap.toggle_breakpoint)
map('n', '<space>dB', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)
map('n', '<space>dl', function()
  require 'telescope'.extensions.dap.list_breakpoints {}
end)
map('n', '<space>dL', dap.clear_breakpoints)
map('n', '<space>dc', function()
  require 'telescope'.extensions.dap.commands {}
end)
map('n', '<space>dr', dap.continue)
map('n', '<F5>', dap.continue)
-- map('n', '<space>dc', dap.run_to_cursor)
map('n', '<F8>', dap.step_over)
map('n', '<space>do', dap.step_over)
map('n', '<space>di', dap.step_into)
map('n', '<space>dI', dap.step_out)
map('n', '<space>dd', dap.repl.toggle)
-- map('n', '<space>dr', dap.run_last)
map('n', '<space>dq', function()
  dap.terminate({}, {})
end)
map('n', '<space>dx', function()
  dap.terminate({}, {})
end)
map({ 'n', 'v' }, '<space>de', function()
  local ok, dapui = pcall(require, 'dapui')
  if not ok then
    return
  end
  dapui.eval('', {})
end)
map('n', '<space>dt', function()
  local ok, dap_go = pcall(require, 'dap-go')
  if not ok then
    return
  end
  dap_go.debug_test()
end)

-- Trouble Mappings
vim.api.nvim_set_keymap('n', '<space>ee', '<cmd>TroubleToggle<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>ed', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>eD', '<cmd>TroubleToggle document_diagnostics<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>el', '<cmd>TroubleToggle loclist<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>eq', '<cmd>TroubleToggle quickfix<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>er', '<cmd>TroubleToggle lsp_references<cr>', opts)

-- NvimTree Mappings
vim.api.nvim_set_keymap('n', '<leader>!', '<cmd>NvimTreeFindFile<cr>', opts)

-- Zen Mode Mappings
map('n', '<leader>z', function()
  require('zen-mode').toggle({
    window = {
      width = .85 -- width will be 85% of the editor width
    }
  })
end)

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
map({ 'i', 's' }, '<C-y>', function()
  if luasnip.get_active_snip() then
    require('luasnip.extras.select_choice')()
  end
end)
-- Luasnip choice selection using vim.ui.select
map({ 'i' }, '<C-u>', function()
  if luasnip.get_active_snip() then
    require('luasnip.extras.select_choice')()
  end
end)
map('n', '<leader>s', function()
  require("luasnip.loaders.from_lua").edit_snippet_files()
end)

-- UndoTree
vim.api.nvim_set_keymap('n', '<space>u', '<cmd>UndotreeToggle<cr>', opts)

local has_jdtls, jdtls = pcall(require, 'jdtls')
if has_jdtls then
  map('n', '<space>jr', jdtls.update_project_config)
end

-- Hop.nvim
local has_hop, hop = pcall(require, 'hop')
if has_hop then
  local hop_hint = require 'hop.hint'
  map('', 't', function()
    hop.hint_char1({ direction = hop_hint.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1,
      teasing = false })
  end, {})
  map('', 'T', function()
    hop.hint_char1({ direction = hop_hint.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1,
      teasing = false })
  end, {})
  map('', 'f', function()
    hop.hint_char1({ direction = hop_hint.HintDirection.AFTER_CURSOR, current_line_only = true, teasing = false })
  end, {})
  map('', 'F', function()
    hop.hint_char1({ direction = hop_hint.HintDirection.BEFORE_CURSOR, current_line_only = true, teasing = false })
  end, {})
  map('', '<space>f', function()
    hop.hint_words({ direction = hop_hint.HintDirection.AFTER_CURSOR, current_line_only = false, teasing = false })
  end, {})
  map('', '<space>F', function()
    hop.hint_words({ direction = hop_hint.HintDirection.BEFORE_CURSOR, current_line_only = false, teasing = false })
  end, {})
end
