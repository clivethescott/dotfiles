" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction


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

augroup filetype_go
    autocmd!
    autocmd FileType go nnoremap <leader>b :<C-u>call <SID>build_go_files()<CR>
    autocmd FileType go nnoremap <buffer> <leader>R :GoRun<CR>
    autocmd FileType go nnoremap <silent> <buffer> <leader>f :GoFmt<CR>
    autocmd FileType go nnoremap <buffer> <leader>t :GoTest<CR>
    autocmd FileType go nnoremap <buffer> <leader>T :GoTestFunc<CR>
    autocmd FileType go nnoremap <silent> <buffer>gt :GoAlternate<CR>
    autocmd FileType go nnoremap <buffer>gr :GoReferrers<CR>
    autocmd FileType go nnoremap <buffer>gi :GoImplements<CR>
    autocmd FileType go nnoremap <silent> <buffer>gb :GoCoverageBrowser<CR>
    " autocmd FileType go nnoremap <silent> <buffer>gc :GoCoverage<CR>
    autocmd FileType go nnoremap <silent> <buffer>gC :GoCoverageToggle<CR>
    autocmd FileType go nnoremap <silent> <buffer>gl :cclose<CR>
    autocmd FileType go nnoremap <silent> <buffer>gL :lclose<CR>
    autocmd FileType go nnoremap <buffer> <leader>r :GoRename<CR>
      " Use :GV Open Go alternate file in vertical split
    autocmd Filetype go command! -bang GV call go#alternate#Switch(<bang>0, 'vsplit')
augroup END
