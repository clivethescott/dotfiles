filetype off

call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Use already available FZF
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
Plug 'itchyny/vim-gitbranch'
Plug 'itchyny/lightline.vim'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python' }
Plug 'airblade/vim-gitgutter'
" The premiere Git plugin for Vim or Vim plugin for Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
" Case relative replacements
Plug 'tpope/vim-abolish'
Plug 'fatih/vim-go',  { 'do': ':GoUpdateBinaries' }
" Protobuf syntax highlighting
Plug 'uarun/vim-protobuf'
" Start menu
Plug 'mhinz/vim-startify'

call plug#end()

filetype plugin indent on
