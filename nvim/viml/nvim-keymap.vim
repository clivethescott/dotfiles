let mapleader=","

" --------------------------------------------------------------
" Vim keymaps 
" --------------------------------------------------------------

" Close quickfix window
nmap <silent><leader>c :cclose<CR>
" Clear highlight
nnoremap <silent><leader>m :silent! nohls<cr>
nnoremap <leader>2 :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>4 :Startify<CR>
" Alternative buffer
nnoremap <silent> <tab> :b#<CR>
" Split movements in all modes
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l

" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

nnoremap <C-S> :w<CR>
inoremap <C-S> <esc>:w<CR>

nnoremap ' `
nnoremap Q :q<CR>

noremap! <C-BS> <C-w>

" We shouldn't be using these anyway
nnoremap <left> <nop>
vnoremap <left> <nop>
nnoremap <right> <nop>
vnoremap <right> <nop>
nnoremap <down> <nop>
vnoremap <down> <nop>
nnoremap <up> <nop>
vnoremap <up> <nop>

" Keep indent/outdent after first indent/outdent in visual mode
vnoremap < <gv
vnoremap > >gv

nnoremap <silent> g> :diffput<CR>
nnoremap <silent> g< :diffget<CR>
nnoremap <silent> tn :tabnext<CR>
nnoremap <silent> tp :tabprevious<CR>
nnoremap <silent> tN :tabnew<CR>
nnoremap <silent> tc :tabclose<CR>

