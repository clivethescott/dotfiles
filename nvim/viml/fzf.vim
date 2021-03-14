" Open FZF window in center of screen
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
" Change default FZF keys for opening a match
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-y': 'vsplit' }
" let g:fzf_history_dir = '~/.local/share/fzf-history'

nnoremap <c-p> :Files<CR> 
nnoremap <c-e> :Buffers<CR> 
nnoremap <c-f> :Rg<CR>
nnoremap <silent><nowait><space>f <ESC>:BLines<CR>
nnoremap <silent><nowait><space>c <ESC>:BCommits<CR>
nnoremap <silent><nowait><space>C <ESC>:Commits<CR>
nnoremap <silent><nowait><space>/ <ESC>:History/<CR>
nnoremap <silent><nowait><space>a <ESC>:Commands<CR>
nnoremap <silent><nowait><space>m <ESC>:Marks<CR>
" Insert mode completion
" Replace the default dictionary completion with fzf-based fuzzy completion
inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')
imap <c-x><c-l> <plug>(fzf-complete-line)
