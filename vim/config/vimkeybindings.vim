" Switch to alternative buffer
nnoremap <bs> :b#<CR>

" Quit all buffers
nnoremap Q :qall<CR>

" Use shift U for re-do
nnoremap <S-U> <C-R>
 
" Clipboard shortcuts
nnoremap <leader>y "+y
nnoremap <leader>p "+p

noremap <leader>l :Autoformat<CR>

" Split lines
nnoremap K i<CR><Esc>

" Undo tree
nnoremap <leader>g :UndotreeToggle<cr>

" Clear highlighted searches
nnoremap <esc><esc> :noh<return><esc>
