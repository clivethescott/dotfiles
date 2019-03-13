" Make code look pretty
let python_highlight_all=1

" PEP 8 guidelines
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" Run python files from within Vim
autocmd BufWinEnter *.py nnoremap <leader>r :w<CR>:!python3 %:p<CR>
