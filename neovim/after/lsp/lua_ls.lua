local data_path = vim.fn.stdpath('data')
local function pack(name)
  return vim.fs.joinpath(data_path, '/site/pack/core/opt/', name)
end

---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT'
      },
      diagnostics = {
        -- Luasnip shortcuts https://github.com/L3MON4D3/LuaSnip/blob/69cb81cf7490666890545fef905d31a414edc15b/lua/luasnip/config.lua#L82-L104
        globals = { 'vim', 'parse', 's', 'sn', 't', 'f', 'i', 'c', 'fmt', 'rep', 'wezterm' },
        unusedLocalExcludes = { '_*' },
        disable = { 'missing-fields', 'missing-parameter' },
      },
      completion = {
        callSnippet = 'Replace',
      },
      hint = {
        enable = true,
      },
      format = {
        enable = true,
      },
      telemetry = {
        enable = false,
      },
      workspace = {
        checkThirdParty = false,
        ignoreDir = { '.archived' },
        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
          -- pack('nvim-lspconfig'),
          -- pack('blink.cmp'),
          -- pack('nvim-treesitter'),
          -- pack('render-markdown.nvim'),
          -- pack('obsidian.nvim'),
          pack('wezterm-types'),
        },
      },
    },
  },
}
