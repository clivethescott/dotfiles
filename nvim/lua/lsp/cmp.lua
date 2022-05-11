local M = {}
M.setup = function()

  local has_cmp, cmp = pcall(require, 'cmp')

  if not has_cmp then
    return
  end

  local has_luasnip, luasnip = pcall(require, 'luasnip')
  local select_next_item = function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif has_luasnip and luasnip.expand_or_locally_jumpable() then
      luasnip.expand_or_jump()
    else
      fallback()
    end
  end

  local select_prev_item = function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif has_luasnip and luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end

  local has_lspkind, lspkind = pcall(require, 'lspkind')
  local cmp_format = {}
  if has_lspkind then
    cmp_format = lspkind.cmp_format {
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    }
  end

  cmp.setup({
    formatting = {
      format = cmp_format
    },
    preselect = cmp.PreselectMode.None,
    completion = {
      keyword_length = 2 -- number of characters needed to trigger auto-completion
    },
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        if has_luasnip then
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-u>'] = cmp.mapping.scroll_docs(4),
      -- ['<C-y>'] = cmp.mapping.complete(),
      -- ['<C-x>'] = cmp.mapping.abort(),
      ['<C-x>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<C-n>'] = cmp.mapping(select_next_item, { 'i', 's' }),
      ['<Tab>'] = cmp.mapping(select_next_item, { 'i', 's' }),

      ['C-p'] = cmp.mapping(select_prev_item, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(select_prev_item, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'path', max_item_count = 30 },
    }, {
      { name = 'nvim_lsp', max_item_count = 20, keyword_length = 1},
      { name = 'nvim_lua', max_item_count = 5},
      { name = 'luasnip', max_item_count = 5, keyword_length = 2 },
      { name = 'nvim_lsp_signature_help' },
      { name = 'nvim_lsp_document_symbol', max_item_count = 10},
      { name = 'buffer', max_item_count = 5, keyword_length = 3 },
    }, {
      { name = 'calc' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  --[[ cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
}) ]]

  --[[ -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
}) ]]
end

return M