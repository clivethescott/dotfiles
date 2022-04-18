" Sort branches/tags by committer date. 
" Minus sign to show in reverse order (recent first):
let g:fzf_checkout_git_options = '--sort=-committerdate'

" Define checkout as the only action for branches:
let g:fzf_checkout_merge_settings = v:false
let g:fzf_branch_actions = {
      \ 'delete': {
      \   'prompt': 'Delete> ',
      \   'execute': 'echo system("{git} -C {cwd} branch -D {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-d',
      \   'required': ['branch'],
      \   'confirm': v:true,
      \ },
      \ 'checkout': {
      \   'prompt': 'Checkout> ',
      \   'execute': 'echo system("{git} -C {cwd} checkout {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'enter',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \ 'track': {
      \   'prompt': 'Track> ',
      \   'execute': 'echo system("{git} -C {cwd} checkout --track {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-t',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
  \}

nnoremap <leader>gg :GBranches<CR>
