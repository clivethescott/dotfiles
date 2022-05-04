local map = function(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- Dealing with word wrap on long lines
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })

-- Center search result
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', '#', '#zz')
map('n', '*', '*zz')

-- Remove search highlight
map('n', '<leader>m', ':silent! nohls<cr>')

-- Alternate buffer
map('n', '<tab>', ':b#<cr>')

-- Split movements
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')

-- Resize v-splits
map('n', '<space><', '10<c-w><')
map('n', '<space>>', '10<c-w>>')

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

-- Keep indent/outdent after first indent/outdent in visual mode
map('v', '<', '<gv')
map('v', '>', '>gv')

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
  telescope.grep_string {
    cwd = '~/.config/nvim/lua'
  }
end)
map('n', '<leader>t', telescope.builtin)
map('n', '<leader>tf', telescope.live_grep)
map('n', '<leader>tb', telescope.current_buffer_fuzzy_find)
map('n', '<c-f>', telescope.current_buffer_fuzzy_find)
map('n', '<leader>tc', telescope.commands)
map('n', '<leader>tm', telescope.marks)
map('n', '<leader>tj', telescope.jumplist)
map('n', '<leader>tr', telescope.registers)
map('n', '<leader>tk', telescope.keymaps)
map('n', '<leader>th', telescope.help_tags)
-- map('n', '<space>fs', telescope.spell_suggest)
map('n', '<leader>gc', telescope.git_commits)
map('n', '<leader>gb', telescope.git_bcommits)
map('n', '<leader>gg', telescope.git_branches)
map('n', '<leader>gs', telescope.git_status)
map('n', '<leader>go', telescope.oldfiles)
-- map('n', '<space>ts', telescope.treesitter)
-- map('n', '<leader>sh', telescope.help_tags)
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
map('n', '<space>dbc', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)
map('n', '<space>dbs', dap.list_breakpoints)
map('n', '<space>dbd', dap.clear_breakpoints)
map('n', '<space>dc', dap.continue)
map('n', '<space>dcc', dap.run_to_cursor)
map('n', '<space>ds', dap.step_over)
map('n', '<space>dss', dap.step_over)
map('n', '<space>dsi', dap.step_into)
map('n', '<space>dso', dap.step_out)
map('n', '<space>do', dap.repl.toggle)
map('n', '<space>dr', dap.run_last)
map('n', '<space>dt', function()
  local cb = function()
    print('Debug Session Terminated')
  end
  dap.terminate({}, {}, cb)
end)

-- Trouble Mappings
local opts = { silent = true, noremap = true }
vim.api.nvim_set_keymap('n', '<space>ee', '<cmd>TroubleToggle<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>ew', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)
vim.api.nvim_set_keymap('n', '<space>ed', '<cmd>TroubleToggle document_diagnostics<cr>', opts)
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
map({ 'i', 's' }, '<C-j>', function()
  if luasnip.expand_or_jumpable() then
    luasnip.jump(1)
  end
end)
map({ 'i', 's' }, '<C-k>', function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end)
-- minimal choice change, same as when using vim.ui.select below
map({ 'i' }, '<C-y>', function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end)
-- Luasnip choice selection using vim.ui.select
map({ 'i' }, '<C-u>', function()
  require('luasnip.extras.select_choice')()
end)
map('n', '<leader>s', function()
  require("luasnip.loaders.from_lua").edit_snippet_files()
end)
