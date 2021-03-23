syntax on

set dictionary+=/usr/share/dict/words
set clipboard=unnamedplus
set cursorline
set noerrorbells
set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab smarttab smartindent
set number relativenumber
set nowrap
set smartcase ignorecase                      
set showmatch
set nobackup nowritebackup noswapfile hidden
set undofile undodir=~/.vim/undodir
set incsearch hlsearch
set encoding=utf-8
set wildmenu                        " Visual autocomplete for command menu
set splitbelow splitright           " Expected split behaviour
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" Shorter delays and better user experience.
set updatetime=100
set colorcolumn=120
"Ignore certain files in tab completion
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jar,*/node_modules/*,*/target/*
set wildignore+=*/.git/*,*.class,*.pyc,*/plugged/*,*/undodir/*,*.png,*.dex
" Don't show that we are now in Insert mode
set noshowmode
set grepprg=rg\ --vimgrep
" Save on make
setlocal autowrite
set formatoptions-=cro                  " Stop newline continution of comments


" Disable NVim's Python 2
let g:loaded_python_provider = 0
" Disable NVim's Perl
let g:loaded_perl_provider = 0
" Disable NVim's Ruby
let g:loaded_ruby_provider = 0
