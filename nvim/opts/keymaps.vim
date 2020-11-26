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
nnoremap <silent> <C-H> :bp<CR>
nnoremap <silent> <C-L> :bn<CR>

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

" --------------------------------------------------------------
" Plugin keymaps 
" --------------------------------------------------------------
" FZF 
nnoremap <c-p> :Files<CR> 
nnoremap <c-e> :Buffers<CR> 
nnoremap <silent><nowait><space>f <ESC>:BLines<CR>
nnoremap <silent><nowait><space>c <ESC>:BCommits<CR>
nnoremap <silent><nowait><space>C <ESC>:Commits<CR>
nnoremap <silent><nowait><space>/ <ESC>:History/<CR>

" Fugitive Git status
nnoremap <silent> gs :GFiles?<CR>

" Git Gutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <leader>gp <Plug>(GitGutterPreviewHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)
nmap <leader>gU <Plug>(Gread)

" NERDTree
nnoremap <silent><leader>1 :NERDTreeToggle<CR>
" Locate current file in NERDTree
nnoremap <silent><leader>! :NERDTreeFind<CR> 

" Undotree
nnoremap <silent> <leader>u :UndotreeToggle<CR>

" --------------------------------------------------------------
" COC keymaps 
" --------------------------------------------------------------
source $HOME/.config/nvim/opts/coc-keymaps.vim
source $HOME/.config/nvim/opts/vimgo-keymaps.vim

