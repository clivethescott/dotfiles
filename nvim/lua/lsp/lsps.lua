-- LSP settings
local map = vim.keymap.set
local has_telescope, telescope_builtin = pcall(require, 'telescope.builtin')

local on_attach = function(client, bufnr)
  -- vim.notify('LSP connected client ' .. client.name, 'info')
  local opts = { buffer = bufnr, silent = true }
  local caps = client.server_capabilities

  if has_telescope then
    map('n', 'gd', telescope_builtin.lsp_definitions, opts)
    map('n', 'gi', telescope_builtin.lsp_implementations, opts)
    map('n', 'gy', telescope_builtin.lsp_type_definitions, opts)
    map('n', 'gr', function()
      telescope_builtin.lsp_references { include_declaration = false }
    end, opts)
    map('n', '<space>ws', telescope_builtin.lsp_dynamic_workspace_symbols, opts)
    map('n', '<space>wS', telescope_builtin.lsp_document_symbols, opts)
    map('n', '<leader>d', telescope_builtin.diagnostics, opts)
  else
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', 'gi', vim.lsp.buf.implementation, opts)
    map('n', 'gy', vim.lsp.buf.type_definition, opts)
    map('n', 'gr', vim.lsp.buf.references, opts)
    map('n', '<space>ws', vim.lsp.buf.workspace_symbol, opts)
    map('n', '<space>wS', vim.lsp.buf.document_symbol, opts)
    map('n', '<leader>d', vim.lsp.buf.diagnostics, opts)
  end

  map('n', 'ga', vim.lsp.buf.code_action, opts)
  map('n', 'gD', vim.lsp.buf.declaration, opts)
  map('n', 'K', vim.lsp.buf.hover, opts)
  map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  map('n', 'gs', vim.lsp.buf.signature_help, opts)
  map('n', 'gl', vim.lsp.codelens.run, opts)
  map('n', '<leader>r', vim.lsp.buf.rename, opts)
  map('n', '<leader>R', function()
    require('helper.utils').rename()
  end, opts)

  -- Formatting
  if caps.documentFormattingProvider then
    map('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end

  if caps.documentRangeFormattingProvider then
    map('v', '<leader>f', vim.lsp.buf.range_formatting, opts)
  end

  -- Diagnostics
  map('n', 'g[', function() vim.diagnostic.goto_prev { wrap = false } end, opts) -- prevent previous jumping back
  map('n', 'g]', vim.diagnostic.goto_next, opts)
  map('n', '<leader>D', function()
    vim.diagnostic.open_float({ scope = 'line' }) -- can be line, buffer, cursor
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true -- broadcasting snippet capability for completion
local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if has_cmp then
  -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
  capabilities = cmp_lsp.update_capabilities(capabilities)
end

-- LSP installer (must be called before lspconfig below)
local has_lspinstall, lspinstall = pcall(require, 'nvim-lsp-installer')
if has_lspinstall then
  lspinstall.setup({
    ensure_installed = { 'sumneko_lua', 'golangci_lint_ls', 'gopls', 'html', 'json', 'tsserver', 'pyright', 'jdtls' },
    ui = {
      icons = {
        server_installed = "✓",
        server_pending = "➜",
        server_uninstalled = "✗"
      }
    },
    log_level = vim.log.levels.WARN,
  })
end

local configs = { 'cmp', 'metals', 'dap', 'golang', 'tsserver', 'html', 'pyright', 'luaserver', 'json', 'java' }
table.insert(configs, 'null-ls') -- add null-ls at the end

for _, config in ipairs(configs) do
  local ok, conf = pcall(require, 'lsp.' .. config)
  if ok then
    conf.setup(on_attach, capabilities)
  end
end
