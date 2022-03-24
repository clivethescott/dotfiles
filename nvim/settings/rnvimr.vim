" Make Ranger replace netrw and be the file explorer
let g:rnvimr_ex_enable = 1
" Hide the files included in gitignore
let g:rnvimr_hide_gitignore = 1
" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_enable_bw = 1
" Map Rnvimr action
let g:rnvimr_action = {
            \ '<C-s>': 'NvimEdit split',
            \ '<C-t>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
" Customize the initial layout
let g:rnvimr_layout = {
            \ 'relative': 'editor',
            \ 'width': float2nr(round(0.8 * &columns)),
            \ 'height': float2nr(round(0.7 * &lines)),
            \ 'col': float2nr(round(0.15 * &columns)),
            \ 'row': float2nr(round(0.15 * &lines)),
            \ 'style': 'minimal'
            \ }

nnoremap <leader>1 :RnvimrToggle<CR>
tnoremap <silent> <leader>1 <C-\><C-n>:RnvimrToggle<CR>
