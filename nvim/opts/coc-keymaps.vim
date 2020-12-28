function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Used in the tab autocompletion for coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> g] <Plug>(coc-diagnostic-prev)
nmap <silent> g[ <Plug>(coc-diagnostic-next)
nnoremap <silent><nowait> <leader>d  :<C-u>CocList diagnostics<cr>
" Formatting selected code.
vmap <silent> <leader>f <Plug>(coc-format-selected)
nmap <silent> <leader>f :call CocAction('format')<CR>
nmap <silent> <space>p :call CocActionAsync('showSignatureHelp')<CR>
" Symbol renaming.
nmap <leader>r <Plug>(coc-rename)
xmap <leader>. <Plug>(coc-codeaction-selected)
nmap <leader>. <Plug>(coc-codeaction)
nmap qf  <Plug>(coc-fix-current)
" Use K to show documentation in preview window.
nmap <silent> K :call <SID>show_documentation()<CR>
" Used to expand decorations in worksheets
nmap <Leader>ws <Plug>(coc-metals-expand-decoration)

" Yank list
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
" Coc tab completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <cr> to confirm completion
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use <c-space> to trigger COC
inoremap <silent><expr> <c-space> coc#refresh()
" Coc-snippets
nnoremap <leader>s :CocCommand snippets.editSnippets<CR>
imap <C-y> <Plug>(coc-snippets-expand)
