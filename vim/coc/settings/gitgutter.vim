function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

" Disable git gutter default keymaps, we'll define our own
let g:gitgutter_map_keys = 0
let g:gitgutter_git_executable = '/usr/bin/git'
let g:gitgutter_grep = 'rg'

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <leader>gP <Plug>(GitGutterPreviewHunk)
nmap <leader>gU <Plug>(GitGutterUndoHunk)

