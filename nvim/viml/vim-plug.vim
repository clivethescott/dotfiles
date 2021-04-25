filetype off

call plug#begin(stdpath('config') . '/plugged')
 " We recommend updating the parsers on update 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Use already available FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
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
" Ranger plugin
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

" File managers
" Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'lambdalisue/fern.vim'
" Plug 'lambdalisue/fern-git-status.vim'
" Plug 'lambdalisue/fern-renderer-nerdfont.vim'
" Plug 'lambdalisue/nerdfont.vim'
"

call plug#end()

filetype plugin indent on
