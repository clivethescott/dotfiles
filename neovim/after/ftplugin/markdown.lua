-- :h treesitter-highlight
vim.api.nvim_set_hl(0, '@markup.heading.1', { fg = '#e06c75', bg = '#2c1f1f', bold = true })
vim.api.nvim_set_hl(0, '@markup.heading.2', { fg = '#d19a66', bg = '#2c251f', bold = true })
vim.api.nvim_set_hl(0, '@markup.heading.3', { fg = '#e5c07b', bg = '#2c2a1f', bold = true })
vim.api.nvim_set_hl(0, '@markup.heading.4', { fg = '#61afef', bg = '#1f252c', bold = true })
vim.api.nvim_set_hl(0, '@markup.heading.5', { fg = '#c678dd', bg = '#261f2c', bold = true })
vim.api.nvim_set_hl(0, '@markup.heading.6', { fg = '#56b6c2', bg = '#1f2a2c', bold = true })
vim.api.nvim_set_hl(0, '@markup.raw', { bg = '#0f1211', bold = false })
vim.api.nvim_set_hl(0, '@markup.raw.block', { bg = '#0f1211', bold = false })
vim.api.nvim_set_hl(0, "@markup.link.label", { link = "Question" })
vim.api.nvim_set_hl(0, "@markup.link", { link = "Tabline" })


-- seems like we need these otherwise the rendered view won't look right
for i = 1, 6, 1 do
  vim.api.nvim_set_hl(0, 'RenderMarkdownH' .. tostring(i) .. 'Bg', { link = '@markup.heading.' .. tostring(i) })
end

vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = '#0f1211', bold = false })
