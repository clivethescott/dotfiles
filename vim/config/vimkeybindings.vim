" Switch to alternative buffer
nnoremap <tab> :b#<CR>

" Quit all buffers
nnoremap Q :qall<CR>

" Use shift U for re-do
" nnoremap <S-U> <C-R>

" Clipboard shortcuts
nnoremap <leader>y "+y
nnoremap <leader>p "+p

noremap <leader>l :Autoformat<CR>

" Split lines
nnoremap K i<CR><Esc>

" Undo tree
nnoremap <leader>g :UndotreeToggle<cr>

" Turn of highlighted search results
nnoremap <esc><esc> :silent! nohls<cr>

" Send to the black hole of death
nnoremap <leader>d "_d
xnoremap <leader>d "_d

" We shouldn't be using these anyway
nnoremap <left> <nop>
inoremap <left> <nop>
vnoremap <left> <nop>

nnoremap <right> <nop>
inoremap <right> <nop>
vnoremap <right> <nop>

nnoremap <down> <nop>
inoremap <down> <nop>
vnoremap <down> <nop>

nnoremap <up> <nop>
inoremap <up> <nop>
vnoremap <up> <nop>
