let b:ctrlp_user_command = 'rg %s --files --type go'
" Save on make
setlocal autowrite
" Go syntax highlighting
let g:go_gopls_enabled = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
" Run meta linter on save
" let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = "3s"


" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Map keys for most used commands.
nnoremap <buffer> <leader>b :<C-u>call <SID>build_go_files()<CR>
nnoremap <buffer> <leader>R :GoRun<CR>
nnoremap <silent> <buffer> <leader>f :GoFmt<CR>
nnoremap <buffer> <leader>t :GoTest<CR>
nnoremap <buffer> <leader>T :GoTestFunc<CR>
nnoremap <silent> <buffer>gt :GoAlternate<CR>
nnoremap <buffer>gr :GoReferrers<CR>
nnoremap <buffer>gi :GoImplements<CR>
nnoremap <silent> <buffer>gc :GoCoverage<CR>
nnoremap <silent> <buffer>gb :GoCoverageBrowser<CR>
nnoremap <silent> <buffer>gC :GoCoverageClear<CR>
nnoremap <silent> <buffer>gl :cclose<CR>
nnoremap <silent> <buffer>gL :lclose<CR>
nnoremap <buffer> <leader>r :GoRename<CR>
nnoremap <buffer> K :GoDoc<CR>
