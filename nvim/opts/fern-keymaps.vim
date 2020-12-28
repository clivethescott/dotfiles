noremap <silent> <Leader>1 :Fern . -drawer -width=35 -toggle<CR><C-w>=
noremap <silent> <Leader>! :Fern . -drawer -reveal=% -width=35<CR><C-w>=

function! s:init_fern() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> t <Plug>(fern-action-mark:toggle)
  nmap <buffer> T <Plug>(fern-action-terminal:vsplit)
  nmap <buffer> n <Plug>(fern-action-new-file)
  nmap <buffer> d <Plug>(fern-action-new-dir)
  " Requires trash-cli installed
  nmap <buffer> D <Plug>(fern-action-trash)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> r <Plug>(fern-action-rename)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> R <Plug>(fern-action-reload)
  nmap <buffer> o <Plug>(fern-action-open:system)
  nmap <buffer> <nowait> h <Plug>(fern-action-hidden:toggle)
  nmap <buffer> <nowait> < <Plug>(fern-action-leave)
  nmap <buffer> <nowait> > <Plug>(fern-action-enter)
  " Just like NERTree
  nmap <buffer> ma <Plug>(fern-action-new-path)
  " nmap <buffer> h <Plug>(fern-action-hide-toggle)
  nmap <buffer> q :<C-u>quit<CR>
  augroup FernTypeGroup
    autocmd! * <buffer>
    autocmd BufEnter <buffer> silent execute "normal \<Plug>(fern-action-reload)"
  augroup END
endfunction

augroup FernEvents
  autocmd!
  autocmd FileType fern call s:init_fern()
augroup END

