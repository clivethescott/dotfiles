
" Map keys for most used commands.
nnoremap <buffer> <leader>b :<C-u>call <SID>build_go_files()<CR>
nnoremap <buffer> <leader>R :GoRun<CR>
nnoremap <silent> <buffer> <leader>f :GoFmt<CR>
nnoremap <buffer> <leader>t :GoTest<CR>
nnoremap <buffer> <leader>T :GoTestFunc<CR>
nnoremap <silent> <buffer>gt :GoAlternate<CR>
nnoremap <buffer>gr :GoReferrers<CR>
nnoremap <buffer>gi :GoImplements<CR>
nnoremap <silent> <buffer>gc :GoCoverage<CR>
nnoremap <silent> <buffer>gb :GoCoverageBrowser<CR>
nnoremap <silent> <buffer>gC :GoCoverageClear<CR>
nnoremap <silent> <buffer>gl :cclose<CR>
nnoremap <silent> <buffer>gL :lclose<CR>
nnoremap <buffer> <leader>r :GoRename<CR>
" nnoremap <buffer> K :GoDoc<CR>
