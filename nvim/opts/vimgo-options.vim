let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_gopls_enabled = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_structs = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
" Add the failing test name to the output of :GoTest
let g:go_test_show_name = 0
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
" Run meta linter on save
" let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = '3s'
let g:go_test_timeout = '8s'
" Don't use location window
let g:go_list_type = "quickfix"
" Only show variable and stacktrace windows when debugging
let g:go_debug_windows = {
      \ 'vars':       'rightbelow 60vnew',
      \ 'stack':      'rightbelow 10new',
\ }

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1
