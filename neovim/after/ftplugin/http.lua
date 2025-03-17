-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/http/highlights.scm
vim.api.nvim_set_hl(0, "@string.http", { link = "ErrorMsg" })
vim.api.nvim_set_hl(0, "@operator.http", { link = "ErrorMsg" })
vim.api.nvim_set_hl(0, "@request.body", { link = "Directory" })
vim.api.nvim_set_hl(0, "@variable.declaration", { link = "ErrorMsg" })
vim.api.nvim_set_hl(0, "@request.url", { link = "CursorLineNr" })
vim.api.nvim_set_hl(0, "@variable.identifier", { link = "Type" })
vim.api.nvim_set_hl(0, "@variable.value", { link = "Character" })
vim.api.nvim_set_hl(0, "@header.value", { link = "FloatTitle" })
vim.api.nvim_set_hl(0, "@request.name", { link = "String" })

vim.bo.commentstring = '# %s'
