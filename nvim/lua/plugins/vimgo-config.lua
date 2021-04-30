vim.g.go_def_mode='gopls'
vim.g.go_info_mode='gopls'
vim.g.go_gopls_enabled = true
vim.g.go_highlight_fields = true
vim.g.go_highlight_functions = true
vim.g.go_highlight_function_calls = true
vim.g.go_highlight_types = true
vim.g.go_highlight_structs = true
vim.g.go_highlight_extra_types = true
vim.g.go_highlight_operators = true
-- Add the failing test name to the output of :GoTest
vim.g.go_test_show_name = false
-- disable vim-go :GoDef short cut (gd)
-- this is handled by LanguageClient [LC]
vim.g.go_def_mapping_enabled = false
-- Run meta linter on save
-- let g:go_metalinter_autosave = 1
vim.g.go_metalinter_deadline = '3s'
vim.g.go_test_timeout = '8s'
-- Don't use location window
vim.g.go_list_type = "quickfix"
-- Only show variable and stacktrace windows when debugging
vim.g.go_debug_windows = {
  vars = 'rightbelow 60vnew',
  stack = 'rightbelow 10new'
}

-- Auto formatting and importing
vim.g.go_fmt_autosave = 1
vim.g.go_fmt_command = "goimports"
vim.g.go_rename_command = "gorename"

-- Status line types/signatures
vim.g.go_auto_type_info = false
