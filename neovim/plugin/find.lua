function Fd(match)
  local files = vim.fn.systemlist(
    'fd --type file --follow --color=never --max-depth=8 --exclude ".git" --exclude "target" --full-path '
    .. match
  )
  return vim.fn.matchfuzzy(files, match)
end

vim.o.findfunc = 'v:lua.Fd'
vim.keymap.set('n', '<M-f>', ':find ')
vim.keymap.set('i', '<M-f>', '<esc>:find ')
