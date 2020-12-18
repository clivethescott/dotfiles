" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction


augroup filetype_go
    autocmd!
    autocmd FileType go nnoremap <leader>b :<C-u>call <SID>build_go_files()<CR>
    autocmd FileType go nnoremap <buffer> <leader>R :GoRun<CR>
    autocmd FileType go nnoremap <silent> <buffer> <leader>f :GoFmt<CR>
    autocmd FileType go nnoremap <buffer> <leader>t :GoTest<CR>
    autocmd FileType go nnoremap <buffer> <leader>T :GoTestFunc<CR>
    autocmd FileType go nnoremap <silent> <buffer>gt :GoAlternate<CR>
    autocmd FileType go nnoremap <buffer>gr :GoReferrers<CR>
    autocmd FileType go nnoremap <buffer>gi :GoImplements<CR>
    autocmd FileType go nnoremap <silent> <buffer>gb :GoCoverageBrowser<CR>
    " autocmd FileType go nnoremap <silent> <buffer>gc :GoCoverage<CR>
    autocmd FileType go nnoremap <silent> <buffer>gC :GoCoverageToggle<CR>
    autocmd FileType go nnoremap <silent> <buffer>gl :cclose<CR>
    autocmd FileType go nnoremap <silent> <buffer>gL :lclose<CR>
    autocmd FileType go nnoremap <buffer> <leader>r :GoRename<CR>
augroup END
