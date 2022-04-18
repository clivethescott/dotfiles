filetype off

call plug#begin(stdpath('config') . '/plugged')
 " We recommend updating the parsers on update 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'mhinz/vim-startify'
" FZF
Plug 'junegunn/fzf.vim'
Plug '/opt/homebrew/opt/fzf/'
Plug 'stsewd/fzf-checkout.vim'
" Plug 'fatih/vim-go',  { 'do': ':GoUpdateBinaries' }

" File managers
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'yuki-yano/fern-preview.vim'

Plug 'folke/which-key.nvim'

call plug#end()

lua << EOF
  require("which-key").setup {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 5
      }
    }
  }
EOF

filetype plugin indent on
