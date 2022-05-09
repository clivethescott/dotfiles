-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

if vim.g.colors_name == 'tokyonight' then
  -- More contrast for Line numbers when using tokyonight
  vim.cmd [[highlight LineNr cterm=underline ctermfg=11 guifg=#737aa2 ]]
end
