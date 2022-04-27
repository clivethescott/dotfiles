local ls = require 'luasnip'

ls.config.set_config {
  update_events = 'TextChanged,TextChangedI', -- updates as you type, default is InsertLeave
}

-- Load snippet from sources
-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md

-- Vscode e.g rafamadriz/friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Snipmate e.g honza/vim-snippets
-- We need to tell luasnip that "_" contains global snipmate snippets:
ls.filetype_extend("all", { "_" })
require("luasnip.loaders.from_snipmate").lazy_load() -- Snipmate

-- Lua
-- Default load location is luasnippets directory in rutimepath or change using
-- require("luasnip.loaders.from_lua").load({paths = "~/snippets"})
local lua_loader = require("luasnip.loaders.from_lua")
lua_loader.lazy_load()

vim.api.nvim_create_user_command('LuaSnipEdit', function()
  lua_loader.edit_snippet_files()
end, {})
