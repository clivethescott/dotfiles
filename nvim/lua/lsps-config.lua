-- LSP settings
local map = vim.keymap.set
local lspconfig = require 'lspconfig'

local function actionIf(action, condition, failureMsg)
  return function()
    if condition then action()
    else print(failureMsg)
    end
  end
end

local on_attach = function(client, bufnr)
  -- print('Attaching to ' .. client.name)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  local telescope = require('telescope.builtin')
  local caps = client.resolved_capabilities

  -- Actions with a Telescope Picker
  map('n', 'gd', actionIf(telescope.lsp_definitions, caps.goto_definition, 'Definition unavailable'), opts)
  map('n', 'gi', actionIf(telescope.lsp_implementations, caps.implementation, 'Implementation unavailable'), opts)
  map('n', 'gy', actionIf(telescope.lsp_type_definitions, caps.type_definition, 'Type Definition unavailable'), opts)
  map('n', 'gr', actionIf(telescope.lsp_references, caps.find_references, 'References unavailable'), opts)
  map('n', '<space>wS', actionIf(telescope.lsp_dynamic_workspace_symbols, caps.workspace_symbol, 'Workspace symbol unavailable'), opts)
  map('n', '<space>ws', actionIf(telescope.lsp_document_symbols, caps.document_symbol, 'Document symbol unavailable'), opts)
  map('n', 'ga', actionIf(telescope.lsp_code_actions, caps.code_action, 'Code Action unavailable'), opts)
  map('n', '<leader>d', telescope.diagnostics, opts)

  map('n', 'gD', actionIf(vim.lsp.buf.declaration, caps.declaration, 'Declaration unavailable'), opts)
  map('n', 'K', actionIf(vim.lsp.buf.hover, caps.hover, 'Hover unavailable'), opts)
  map('n', '<C-k>', actionIf(vim.lsp.buf.signature_help, caps.signature_help, 'Signature unavailable'), opts)
  map('n', 'gs', actionIf(vim.lsp.buf.signature_help, caps.signature_help, 'Signature unavailable'), opts)
  map('n', 'gl', actionIf(vim.lsp.codelens.run, caps.code_lens, 'Code Lens unavailable'), opts)
  map('n', '<leader>r', actionIf(vim.lsp.buf.rename, caps.rename, 'Rename unavailable'), opts)

  -- Formatting
  if caps.document_formatting then
    map('n', '<leader>f', vim.lsp.buf.formatting, opts)
  elseif caps.document_range_formatting then
    map('n', '<leader>f', vim.lsp.buf.range_formatting, opts)
  else
    print('Note: Formatting Unavailable')
  end

  -- Diagnostics
  map('n', 'g[', function() vim.diagnostic.goto_prev { wrap = false } end, opts) -- prevent previous jumping back
  map('n', 'g]', vim.lsp.diagnostic.goto_next, opts)
  map('n', '<leader>D', vim.lsp.diagnostic.show_line_diagnostics, opts)
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
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
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
    ['<C-y>'] = cmp.mapping.complete(),
    ['<C-x>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
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
    { name = 'path' },
  }, {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'nvim_lsp_document_symbol' },
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
  local caps = client.resolved_capabilities
  caps.goto_definition = true
  caps.implementation = true
  caps.find_references = true
  caps.workspace_symbol = true
  caps.document_symbol = true
  caps.code_action = true
  caps.hover = true
  caps.signature_help = true
  caps.code_lens = true
  caps.rename = true
  caps.document_formatting = true
  caps.document_range_formatting = true

  on_attach(client, bufnr)
  require('metals').setup_dap()
  -- other settings for metals here

  -- Metals mappings
  map('n', '<leader>c', require('telescope').extensions.metals.commands)
  --[[ Depending on what you're using to display these results, some send in an empty query string to start off the process.
  Since this can potentially be a huge amount of symbols, metals won't respond to an empty query search.
  So for example with telescope, I need to use builtin.lsp_dynamic_workspace_symbols not the normal builtin.lsp_workspace_symbols ]]
  map('n', '<space>wS', telescope.lsp_dynamic_workspace_symbols, opts)
  map('n', 'gD', require('metals').goto_super_method, opts)
end

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "sc" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})


-- Null ls config
local null_ls = require('null-ls')

require("null-ls").setup({
  on_attach = function(client, bufnr)
    local caps = client.resolved_capabilities

    if client.name == 'pyright' then
      caps.document_formatting = true
    end

    on_attach(client, bufnr)
  end,
  sources = {
    -- Code Actions
    null_ls.builtins.code_actions.gitsigns,

    -- Diagnostics
    null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.flake8,

    -- Formatting
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.prettier,

    -- Hover
    null_ls.builtins.hover.dictionary,
  },
})
