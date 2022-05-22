-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank {
      timeout = 500 -- time in ms before highlight is cleared
    }
  end,
  group = highlight_group,
  pattern = '*',
})

  -- More contrast for Line numbers when using tokyonight
if vim.g.colors_name == 'tokyonight' then
  vim.api.nvim_set_hl(0, 'LineNr', { fg = '#737aa2'})
end
vim.api.nvim_set_hl(0, 'WinBarPath', { fg = '#545c7e' })
vim.api.nvim_set_hl(0, 'WinBarModified', { fg = '#e0af68' })
