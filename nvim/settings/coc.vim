" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

let g:coc_global_extensions = [
  \ 'coc-prettier',
  \ 'coc-snippets',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-vimlsp',
  \ 'coc-yank',
  \ 'coc-pyright',
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-lua',
  \ 'coc-yaml',
  \ 'coc-docker',
  \ 'coc-metals',
  \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    " execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Used in the tab autocompletion for coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation.
nmap <silent> gD :call CocAction('jumpDefinition', 'vsplit')<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> g] <Plug>(coc-diagnostic-prev)
nmap <silent> g[ <Plug>(coc-diagnostic-next)
nmap <silent> g[ <Plug>(coc-diagnostic-next)
nmap <silent> gl <Plug>(coc-codelens-action)
nmap g.  <Plug>(coc-fix-current)
" Applying codeAction to the selected region.
xmap gs <Plug>(coc-codeaction-selected)
nmap gs <Plug>(coc-codeaction-selected)
" Buffer code action
nmap <silent> ga <Plug>(coc-codeaction)
nnoremap <silent><nowait> <leader>D  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList symbols<cr>
" Formatting selected code.
xmap <silent> <leader>f <Plug>(coc-format-selected)
vmap <silent> <leader>f <Plug>(coc-format-selected)
nmap <silent> <leader>f :call CocAction('format')<CR>
nmap <silent> <space>p :call CocActionAsync('showSignatureHelp')<CR>
" Symbol renaming.
nmap <leader>r <Plug>(coc-rename)
" Use K to show documentation in preview window.
nmap <silent> K :call <SID>show_documentation()<CR>
" Used to expand decorations in worksheets
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

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Imports` command for organize imports of the current buffer.
command! -nargs=0 Imports :call CocAction('runCommand', 'editor.action.organizeImport')

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Make sure `"codeLens.enable": true` is set in your coc config
" nnoremap <leader>cl <Plug>(coc-codelens-action)

nnoremap <silent> <leader>c :<C-u>CocCommand <CR>
nnoremap <silent> <space>o :CocList outline <CR>
" Fix treesitter syntax highlight issues
" nnoremap <leader>gf :write | edit | TSBufEnable highlight
"
" Snippets
nnoremap <leader>s :CocCommand snippets.editSnippets<CR>
imap <C-y> <Plug>(coc-snippets-expand)
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Nicely show signature of method when auto-completing
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Scala Settings
" Toggle panel with Tree Views
nnoremap <silent> <space>tt :<C-u>CocCommand metals.tvp<CR>
" Toggle Tree View 'metalsPackages'
nnoremap <silent> <space>tp :<C-u>CocCommand metals.tvp metalsPackages<CR>
" Toggle Tree View 'metalsCompile'
nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
" Toggle Tree View 'metalsBuild'
nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
" Reveal current current class (trait or object) in Tree View 'metalsPackages'
nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsPackages<CR>
