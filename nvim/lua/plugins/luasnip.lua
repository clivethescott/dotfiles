return {
  'L3MON4D3/LuaSnip',
  event = 'BufReadPost',
  version = "2.x",
  dependencies = {
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
  },
  config = function()
    local ls = require 'luasnip'
    local types = require("luasnip.util.types")

    ls.config.setup {
      history = false,
      -- update_events = 'TextChanged,TextChangedI', -- updates as you type, default is InsertLeave
      enable_autosnippets = false,                                            -- enabling this has a performance penalty
      ft_func = require("luasnip.extras.filetype_functions").from_cursor_pos, -- use treesitter to get ft
      delete_check_events = { "InsertLeave" },                                -- enable to delete virt text when snippet is deleted
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "<-", "Error" } } -- text + hlgroup, when choosing
          },
        }
      }
    }

    -- Load snippet from sources
    -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md

    -- Vscode e.g rafamadriz/friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Snipmate e.g honza/vim-snippets
    -- We need to tell luasnip that "_" contains global snipmate snippets:
    -- ls.filetype_extend("all", { "_" })
    -- require("luasnip.loaders.from_snipmate").lazy_load() -- Snipmate

    -- Lua
    -- Default load location is luasnippets directory in rutimepath or change using
    -- require("luasnip.loaders.from_lua").load({paths = "~/snippets"})
    local lua_loader = require("luasnip.loaders.from_lua")
    lua_loader.lazy_load()

    vim.api.nvim_create_user_command('LuaSnipEdit', function()
      lua_loader.edit_snippet_files()
    end, {})
  end
}
