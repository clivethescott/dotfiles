" Make nvim use Vim's config
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc
source ~/.config/nvim/mycocsettings.vim
source ~/.config/nvim/ctags.vim

" Make Nvim play nice with virtual environments
let g:python3_host_prog='/usr/bin/python3'
" Disable NVim's Python 2
let g:loaded_python_provider = 0
" Open FZF window in center of screen
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let g:gitgutter_map_keys = 0

" Vim-go settings
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
let g:go_metalinter_deadline = '3s'
let g:go_test_timeout = '8s'


" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1

" Open Go alternate file in vertical split
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'gitbranch', 'gitstatus'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'gitstatus': 'GitStatus'
      \ },
      \ }
