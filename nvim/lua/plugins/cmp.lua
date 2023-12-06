local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-cmdline',
    'uga-rosa/cmp-dictionary',
    {
      'tzachar/cmp-tabnine',
      build = './install.sh',
    },
    {
      'ray-x/lsp_signature.nvim',
      config = true,
    },
    {
      'onsails/lspkind.nvim',
    },
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local select_next_item = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end

    local select_prev_item = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end

    local lspkind = require 'lspkind'
    local source_mapping = {
      buffer = "[Buffer]",
      nvim_lsp = "[LSP]",
      nvim_lua = "[Lua]",
      luasnip = "[Snip]",
      path = "[Path]",
    }

    cmp.setup({
      experimental = {
        ghost_text = false,
      },
      formatting = {
        format = function(entry, vim_item)
          -- if you have lspkind installed, you can use it like
          -- in the following line:
          vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
          vim_item.menu = source_mapping[entry.source.name]
          local maxwidth = 80
          vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
          return vim_item
        end,
      },
      preselect = cmp.PreselectMode.None,
      completion = {
        -- autocomplete = true,
        keyword_length = 1 -- number of characters needed to trigger auto-completion
      },
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          pcall(luasnip.lsp_expand, args.body) -- For `luasnip` users.
        end,
      },
      window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-y>'] = cmp.mapping.complete(),
        -- ['<C-x>'] = cmp.mapping.abort(),
        ['<C-x>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<C-n>'] = cmp.mapping(select_next_item, { 'i', 's' }),
        ['<C-e>'] = cmp.mapping.complete(),
        -- ['<Tab>'] = cmp.mapping(select_next_item, { 'i', 's' }),

        ['<C-p>'] = cmp.mapping(select_prev_item, { 'i', 's' }),
        -- ['<S-Tab>'] = cmp.mapping(select_prev_item, { 'i', 's' }),
      }),
      sources = cmp.config.sources({
        { name = 'path', max_item_count = 30 },
      }, {
        { name = 'luasnip',                  max_item_count = 3, keyword_length = 1 },
        { name = 'nvim_lsp',                 max_item_count = 25 },
        { name = 'cmp_tabnine',              max_item_count = 5, keyword_length = 3 },
        { name = 'nvim_lua',                 max_item_count = 5 },
        -- { name = 'nvim_lsp_signature_help' }, -- now using lsp_signature
        { name = 'nvim_lsp_document_symbol', max_item_count = 5 },
        { name = 'buffer',                   max_item_count = 5, keyword_length = 3 },
        -- { name = "dictionary",               max_item_count = 3, keyword_length = 5 },
      })
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })

    vim.keymap.set('i', '<C-x><C-o>', function() require 'cmp'.complete() end)
  end
}
