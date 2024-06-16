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

vim.api.nvim_set_hl(0, 'WinBarPath', { fg = '#545c7e' })
vim.api.nvim_set_hl(0, 'WinBarModified', { fg = '#e0af68' })

