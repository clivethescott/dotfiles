let mapleader=","

" --------------------------------------------------------------
" Vim keymaps 
" --------------------------------------------------------------

" Alt paste
nmap <c-v> "+p

" Close quickfix window
nmap <silent><leader>c :cclose<CR>
" Clear highlight
nnoremap <silent><leader>m :silent! nohls<cr>
nnoremap <leader>2 :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>3 :e ~/.config/nvim/settings/vim-plug.vim<CR>
nnoremap <leader>4 :Startify<CR>
nnoremap <leader>b :make<CR>
" Alternative buffer
nnoremap <silent> <tab> :b#<CR>
" Split movements in all modes
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Resize v-splits
nnoremap <leader>< 10<C-w><
nnoremap <leader>> 10<C-w>>

nnoremap <silent><C-S> :w<CR>
inoremap <silent><C-S> <esc>:w<CR>

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

" nnoremap <leader> gh :helptags ALL<CR>
nnoremap <silent> g> :diffput<CR>
nnoremap <silent> g< :diffget<CR>
nnoremap <silent> tn :tabnext<CR>
nnoremap <silent> tp :tabprevious<CR>
nnoremap <silent> tN :tabnew<CR>
nnoremap <silent> tc :tabclose<CR>

nnoremap <silent> Y yy

" Use Esc in Terminal + FZF
if has("nvim")
  au TermOpen * tnoremap <Esc><Esc> <c-\><c-n>
  au FileType fzf tunmap <Esc><Esc>
endif
