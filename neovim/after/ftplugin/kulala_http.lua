-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/http/highlights.scm


-- http. See standard captures in :h treesitter-highlight. :Inspect suffixes with filetype


vim.api.nvim_set_hl(0, "@string.special.url", { link = "ErrorMsg" })
vim.api.nvim_set_hl(0, "@constant", { link = "WarningMsg" })
vim.api.nvim_set_hl(0, "@keyword", { link = "NonText" })
vim.api.nvim_set_hl(0, "@variable.value", { link = "ErrorMsg" })

vim.bo.commentstring = '# %s'
