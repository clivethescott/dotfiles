filetype off

call plug#begin('~/.vim/plugged')

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc.nvim', {'commit': '047a87b01d7d2df2ee1f08ef988ef419051778c1'}
" Use already available FZF
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
" Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/goyo.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
" Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
"Plug 'itchyny/vim-gitbranch'
Plug 'itchyny/lightline.vim'
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python' }
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
" Plug 'vimlab/split-term.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
" React/JS Dev
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim', { 'for': 'javascript' }
Plug 'MaxMEllon/vim-jsx-pretty', { 'for': 'javascript' } 
Plug 'peitalin/vim-jsx-typescript', { 'for': 'javascript' } 

call plug#end()

filetype plugin indent on
