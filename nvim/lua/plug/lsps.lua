-- LSP settings
local map = vim.keymap.set
local lspconfig = require 'lspconfig'

local on_attach = function(client, bufnr)
  -- vim.notify('LSP connected client ' .. client.name, 'info')
  local opts = { buffer = bufnr, silent = true }
  local telescope = require('telescope.builtin')
  local caps = client.server_capabilities

  -- Actions with a Telescope Picker
  map('n', 'gd', telescope.lsp_definitions, opts)
  map('n', 'gi', telescope.lsp_implementations, opts)
  map('n', 'gy', telescope.lsp_type_definitions, opts)
  map('n', 'gr', function()
    telescope.lsp_references { include_declaration = false }
  end, opts)
  map('n', '<space>wS', telescope.lsp_dynamic_workspace_symbols, opts)
  map('n', '<space>ws', telescope.lsp_document_symbols, opts)
  map('n', 'ga', vim.lsp.buf.code_action, opts)
  map('n', '<leader>d', telescope.diagnostics, opts)

  map('n', 'gD', vim.lsp.buf.declaration, opts)
  map('n', 'K', vim.lsp.buf.hover, opts)
  map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  map('n', 'gs', vim.lsp.buf.signature_help, opts)
  map('n', 'gl', vim.lsp.codelens.run, opts)
  map('n', '<leader>r', vim.lsp.buf.rename, opts)

  -- Formatting
  if caps.documentFormattingProvider then
    map('n', '<leader>f', function()
      vim.lsp.buf.format{ async = true}
    end, opts)
  elseif caps.documentRangeFormattingProvider then
    map('n', '<leader>f', vim.lsp.buf.range_formatting, opts)
  end

  -- Diagnostics
  map('n', 'g[', function() vim.diagnostic.goto_prev { wrap = false } end, opts) -- prevent previous jumping back
  map('n', 'g]', vim.diagnostic.goto_next, opts)
  map('n', '<leader>D', function()
    vim.diagnostic.open_float({scope = 'line'}) -- can be line, buffer, cursor
  end, opts)
  -- map('n', '<leader>d', vim.diagnostic.setloclist, opts) -- buffer diagnostics only

  -- map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  -- map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  -- map('n', '<leader>wl', function()
  --   vim.inspect(vim.lsp.buf.list_workspace_folders())
  -- end, opts)
  map('n', '<space>we', function()
    vim.diagnostic.setqflist({ severity = 'E' }) -- all workspace errors
  end, opts)
  map('n', '<space>ww', function()
    vim.diagnostic.setqflist({ severity = 'W' }) -- all workspace warnings
  end, opts)

end

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Enable the following language servers
local servers = { 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
  }
end

----------------------------------------------------------------------
-- LUA LSP CONFIG
----------------------------------------------------------------------
-- Make runtime files discoverable to the server
local root_pattern = lspconfig.util.root_pattern
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = root_pattern(".luarc.json", ".luacheckrc", ".stylua.toml", "selene.toml", ".git"),
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global and
        -- Luasnip shortcuts https://github.com/L3MON4D3/LuaSnip/blob/69cb81cf7490666890545fef905d31a414edc15b/lua/luasnip/config.lua#L82-L104
        globals = { 'vim', 'parse', 's', 'sn', 't', 'f', 'i', 'c', 'fmt', 'rep' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

----------------------------------------------------------------------
-- Python LSP CONFIG
----------------------------------------------------------------------
lspconfig.pyright.setup {
  capabilities = capabilities;
  on_attach = on_attach;
  settings = {
    python = {
      analysis = {
        loglevel = 'Error',
        typeCheckingMode = 'strict'
      }
    }
  }
}

----------------------------------------------------------------------
-- Luasnip CONFIG
----------------------------------------------------------------------
local luasnip = require 'luasnip'

----------------------------------------------------------------------
-- HTML LSP CONFIG
----------------------------------------------------------------------
lspconfig.html.setup {
  capabilities = capabilities;
  on_attach = on_attach;
}

----------------------------------------------------------------------
-- Typescript/Javascript LSP CONFIG
----------------------------------------------------------------------
lspconfig.tsserver.setup {
  capabilities = capabilities;
  on_attach = on_attach;
  root_dir = root_pattern('package.json', 'tsconfig.json', 'jsconfig.json')
}

----------------------------------------------------------------------
-- GO LSP CONFIG
----------------------------------------------------------------------
lspconfig.gopls.setup {
  capabilities = capabilities;
  filetypes = { 'go' };
  on_attach = on_attach;
}

----------------------------------------------------------------------
-- nvim-cmp completionLSP CONFIG
----------------------------------------------------------------------
-- Setup nvim-cmp.
local cmp = require 'cmp'

cmp.setup({
  preselect = cmp.PreselectMode.None,
  completion = {
    keyword_length = 2 -- number of characters needed to trigger auto-completion
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
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
    ['<C-x>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['C-p'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'path', max_item_count = 3 },
  }, {
    { name = 'nvim_lua', max_item_count = 5 },
    { name = 'nvim_lsp', max_item_count = 15 },
    { name = 'luasnip', max_item_count = 5 },
    { name = 'nvim_lsp_document_symbol', max_item_count = 10 },
    { name = 'nvim_lsp_signature_help' },
    { name = 'buffer', max_item_count = 5 },
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

----------------------------------------------------------------------
-- Metals LSP CONFIG
----------------------------------------------------------------------
local metals_config = require("metals").bare_config()
-- NOTE: It's highly recommended to set your `statusBarProvider` to `on`. This
-- enables `metals/status` and also other helpful messages that are shown to you
metals_config.init_options.statusBarProvider = "on"
metals_config.settings = {
  serverVersion = 'latest.snapshot',
  showImplicitArguments = true,
  showImplicitConversionsAndClasses = true,
  showInferredType = true,
  serverProperties = { "-Xmx1G" },
  superMethodLensesEnabled = true,
  excludedPackages = {
    "akka.actor.typed.javadsl",
    "com.github.swagger.akka.javadsl"
  }
}
metals_config.capabilities = capabilities

local dap = require 'dap'
dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "Run or Test File",
    metals = {
      runType = "runOrTestFile",
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Build Target",
    metals = {
      runType = "testTarget",
    },
  },
}

metals_config.on_attach = function(client, bufnr)
  on_attach(client, bufnr)
  require('metals').setup_dap()
  -- other settings for metals here

  local opts = { silent = true, noremap = true }
  -- Metals mappings
  map('n', '<leader>c', require('telescope').extensions.metals.commands, opts)
  --[[ Depending on what you're using to display these results, some send in an empty query string to start off the process.
  Since this can potentially be a huge amount of symbols, metals won't respond to an empty query search.
  So for example with telescope, I need to use builtin.lsp_dynamic_workspace_symbols not the normal builtin.lsp_workspace_symbols ]]
  map('n', '<space>wS', telescope.lsp_dynamic_workspace_symbols, opts)

end

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "sc" },
  callback = function()
    -- Metals mappings
    require("metals").initialize_or_attach(metals_config)

  end,
  group = nvim_metals_group,
})


-- Null ls config
local null_ls = require('null-ls')

require("null-ls").setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end,
  sources = {
    -- Code Actions
    null_ls.builtins.code_actions.gitsigns,

    -- Diagnostics
    -- null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.flake8,

    -- Formatting
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.prettier,

    -- Hover
    null_ls.builtins.hover.dictionary,
  },
})
