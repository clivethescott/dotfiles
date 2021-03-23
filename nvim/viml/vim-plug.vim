filetype off

call plug#begin('~/.vim/plugged')

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Use already available FZF
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'honza/vim-snippets'
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'jparise/vim-graphql'
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
Plug 'lambdalisue/nerdfont.vim'
" File manager
" Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'lambdalisue/fern.vim'
" Plug 'lambdalisue/fern-git-status.vim'
" Plug 'lambdalisue/fern-renderer-nerdfont.vim'
"
" Ranger plugin
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

call plug#end()

filetype plugin indent on
