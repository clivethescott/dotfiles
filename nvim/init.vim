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
