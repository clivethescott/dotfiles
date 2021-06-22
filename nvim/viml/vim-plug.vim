filetype off

call plug#begin(stdpath('config') . '/plugged')
 " We recommend updating the parsers on update 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
Plug 'pangloss/vim-javascript'
" Ranger plugin
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" File managers
" Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'lambdalisue/fern.vim'
" Plug 'lambdalisue/fern-git-status.vim'
" Plug 'lambdalisue/fern-renderer-nerdfont.vim'
" Plug 'lambdalisue/nerdfont.vim'
"

call plug#end()

filetype plugin indent on
