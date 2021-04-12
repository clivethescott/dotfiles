filetype off

call plug#begin('~/.vim/plugged')
 " We recommend updating the parsers on update 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Use already available FZF
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'junegunn/goyo.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'honza/vim-snippets'
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'jparise/vim-graphql'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'fatih/vim-go',  { 'do': ':GoUpdateBinaries' }
Plug 'uarun/vim-protobuf'
Plug 'mhinz/vim-startify'
Plug 'lambdalisue/nerdfont.vim'
" File manager config
" Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'lambdalisue/fern.vim'
" Plug 'lambdalisue/fern-git-status.vim'
" Plug 'lambdalisue/fern-renderer-nerdfont.vim'
"
" Ranger plugin
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

call plug#end()

filetype plugin indent on
