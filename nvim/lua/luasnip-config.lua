-- Check https://github.com/L3MON4D3/LuaSnip
--
-- load VSCode-like snippets provided by plugins
require("luasnip.loaders.from_vscode").lazy_load()
-- load snippets from path/of/your/nvim/config/my-cool-snippets
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my-cool-snippets" } })

-- One peculiarity of honza/vim-snippets is that the file with the global snippets is _.snippets, so global snippets
-- are stored in `ls.snippets._`.
-- We need to tell luasnip that "_" contains global snippets:
local ls = require("luasnip")
ls.filetype_extend("all", { "_" })

-- load Snipmate-like snippets provided by plugins
--[[
The snipmate format is very simple, so adding custom snippets only requires a few steps:
1. add a directory beside your init.vim (or any other place that is in your runtimepath) named snippets.
2. inside that directory, create files named <filetype>.snippets and add snippets for the given filetype in it
(for inspiration, check honza/vim-snippets).
]]
require("luasnip.loaders.from_snipmate").lazy_load()
