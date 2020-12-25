let mapleader=","

" --------------------------------------------------------------
" Vim keymaps 
" --------------------------------------------------------------

" Close quickfix window
nmap <silent><leader>c :cclose<CR>
" Clear highlight
nnoremap <silent><leader>m :silent! nohls<cr>
nnoremap <leader>2 :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>3 :e ~/.config/nvim/coc-settings.json<CR>

" Make adjusing split sizes a bit more friendly
nnoremap <silent> <space>h :vertical resize +3<CR>
nnoremap <silent> <space>l :vertical resize -3<CR>
nnoremap <silent> <space>k :resize +3<CR>
nnoremap <silent> <space>j :resize -3<CR>

" Buffer movements
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
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Terminal 
" Lets escape terminal normally
" tnoremap <ESC> <C-\><C-n>

nnoremap Q :qall<CR>
nnoremap <C-S> :w<CR>
inoremap <C-S> <esc>:w<CR>

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

nnoremap > :diffput<CR>
nnoremap < :diffget<CR>

" --------------------------------------------------------------
" Plugin keymaps 
" --------------------------------------------------------------
" FZF 
nnoremap <c-p> :Files<CR> 
nnoremap <c-f> :Rg<CR>
nnoremap <c-e> :Buffers<CR> 
nnoremap <silent><nowait><space>f <ESC>:BLines<CR>
nnoremap <silent><nowait><space>c <ESC>:BCommits<CR>
nnoremap <silent><nowait><space>C <ESC>:Commits<CR>
nnoremap <silent><nowait><space>/ <ESC>:History/<CR>
" Insert mode completion
" Replace the default dictionary completion with fzf-based fuzzy completion
inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')
imap <c-x><c-l> <plug>(fzf-complete-line)

" Fugitive Git status
nnoremap <silent> gs :GFiles?<CR>

" Git Gutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <leader>gp <Plug>(GitGutterPreviewHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)
nmap <leader>gU <Plug>(Gread)

" NERDTree
" nnoremap <silent><leader>1 :NERDTreeToggle<CR>
" Locate current file in NERDTree
" nnoremap <silent><leader>! :NERDTreeFind<CR> 

" Undotree
nnoremap <silent> <leader>u :UndotreeToggle<CR>

" Startify
nnoremap <leader>4 :Startify<CR>
"Split term
nnoremap <silent><space>t :VTerm<ESC>
nnoremap <silent><space>T :Term<ESC>
" --------------------------------------------------------------
" COC keymaps 
" --------------------------------------------------------------
source $HOME/.config/nvim/opts/coc-keymaps.vim
source $HOME/.config/nvim/opts/vimgo-keymaps.vim
source $HOME/.config/nvim/opts/fern-keymaps.vim

