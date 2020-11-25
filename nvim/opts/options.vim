syntax on

set clipboard=unnamedplus
set cursorline
set noerrorbells
set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab smartindent
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

" Plugin Options ----------------------------------------------------

source $HOME/.config/nvim/opts/vimgo-options.vim
" Ultisnips
let g:UltiSnipsExpandTrigger="<c-y>"
" Jump between snippet placeholders
let g:coc_snippet_prev = '<c-s-l>'
let g:coc_snippet_next = '<c-s-k>'
" Make Nvim play nice with virtual environments
let g:python3_host_prog='/usr/bin/python3'
" Disable NVim's Python 2
let g:loaded_python_provider = 0
" Open FZF window in center of screen
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
" Disable git gutter default keymaps, we'll define our own
let g:gitgutter_map_keys = 0
let g:gitgutter_git_executable = '/usr/bin/git'

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

augroup myoptions
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  autocmd BufEnter *.{js,jsx,ts,tsx,py} :syntax sync fromstart
  autocmd BufLeave *.{js,jsx,ts,tsx,py} :syntax sync clear
  autocmd FileType json syntax match Comment +\/\/.\+$+
  " Use :GV Open Go alternate file in vertical split
  autocmd Filetype go command! -bang GV call go#alternate#Switch(<bang>0, 'vsplit')
augroup END
