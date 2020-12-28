" FZF 
nnoremap <c-p> :Files<CR> 
nnoremap <c-e> :Buffers<CR> 
nnoremap <c-f> :Rg<CR>
nnoremap <silent><nowait><space>f <ESC>:BLines<CR>
nnoremap <silent><nowait><space>c <ESC>:BCommits<CR>
nnoremap <silent><nowait><space>C <ESC>:Commits<CR>
nnoremap <silent><nowait><space>/ <ESC>:History/<CR>
" Insert mode completion
" Replace the default dictionary completion with fzf-based fuzzy completion
inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')
imap <c-x><c-l> <plug>(fzf-complete-line)
