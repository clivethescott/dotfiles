" Switch to alternative buffer
nnoremap <bs> :b#<CR>

" Quit all buffers
nnoremap Q :qall<CR>

" Use shift U for re-do
nnoremap <S-U> <C-R>

" Split window mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Clipboard shortcuts
nnoremap <leader>y "+y
nnoremap <leader>p "+p


" Enable folding with the space bar
nnoremap <space> za

noremap <leader>l :Autoformat<CR>

" Split lines
nnoremap K i<CR><Esc>
