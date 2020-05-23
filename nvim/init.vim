" Make nvim use Vim's config
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc
source ~/.config/nvim/mycocsettings.vim

augroup auto-source
    autocmd!
    autocmd BufWritePost vimrc source ~/.config/nvim/init.vim
augroup END

" Make Nvim play nice with virtual environments
let g:python3_host_prog='/usr/bin/python3'
" Disable NVim's Python 2
let g:loaded_python_provider = 0
