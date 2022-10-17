-- LSP settings
local map = vim.keymap.set
local has_telescope, telescope_builtin = pcall(require, 'telescope.builtin')
local utils = require 'helper.utils'

local on_attach = function(client, bufnr)
  -- vim.notify('LSP connected client ' .. client.name, 'info')
  local opts = { buffer = bufnr, silent = true }
  local caps = client.server_capabilities

local has_sig, sig = pcall(require, 'lsp_signature')
  if has_sig then
  sig.on_attach({
    bind = true, --This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded"
    },
    transparency = 20,
    padding = ' ',
    floating_window_off_x = 5,
    floating_window_above_cur_line = true,
    hint_prefix = " ",
  }, bufnr)
  end

  if has_telescope then
    map('n', 'gd', telescope_builtin.lsp_definitions, opts)
    map('n', 'gi', telescope_builtin.lsp_implementations, opts)
    map('n', 'gy', telescope_builtin.lsp_type_definitions, opts)
    map('n', 'gr', function()
      telescope_builtin.lsp_references { include_declaration = false }
    end, opts)
    map('n', '<space>wS', telescope_builtin.lsp_document_symbols, opts)
    map('n', '<space>ws', telescope_builtin.lsp_dynamic_workspace_symbols, opts)
    map('n', '<leader>D', telescope_builtin.diagnostics, opts)
    map('n', '<leader>c', require 'telescope'.extensions.metals.commands, opts)
  else
    map('n', '<space>ws', vim.lsp.buf.workspace_symbol, opts)
    map('n', '<space>wS', vim.lsp.buf.document_symbol, opts)
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', 'gi', vim.lsp.buf.implementation, opts)
    map('n', 'gy', vim.lsp.buf.type_definition, opts)
    map('n', 'gr', vim.lsp.buf.references, opts)
    map('n', '<leader>D', vim.lsp.buf.diagnostics, opts)
  end

  map('n', 'ga', vim.lsp.buf.code_action, opts)
  map('n', 'gD', vim.lsp.buf.declaration, opts)
  map('n', 'K', vim.lsp.buf.hover, opts)
  map('n', 'gh', utils.show_word_help, opts)
  map('n', 'gs', vim.lsp.buf.signature_help, opts)
  map('n', 'gl', vim.lsp.codelens.run, opts)
  -- map('n', '<leader>r', vim.lsp.buf.rename, opts)
  map('n', '<leader>r', vim.lsp.buf.rename, opts)

  -- Formatting

  if caps.documentFormattingProvider then
    map('n', '<leader>f', utils.lsp_buf_format, opts)
  end

  if caps.documentRangeFormattingProvider then
    map('v', '<leader>f', utils.lsp_range_format, opts)
  end

  -- Diagnostics
  map('n', 'g[', function() vim.diagnostic.goto_prev { wrap = false } end, opts) -- prevent previous jumping back
  map('n', 'g]', vim.diagnostic.goto_next, opts)
  map('n', '<leader>d', function()
    vim.diagnostic.open_float({ scope = 'line' }) -- can be line, buffer, cursor
  end, opts)
  -- map('n', '<leader>d', vim.diagnostic.setloclist, opts) -- buffer diagnostics only

  -- map('n', '/leader>wa', vim.lsp.buf.add_workspace_folder, opts)
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
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}
local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if has_cmp then
  -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
  capabilities = cmp_lsp.update_capabilities(capabilities)
end

-- LSP installer (must be called before lspconfig below)
local has_lspinstall, lspinstall = pcall(require, 'nvim-lsp-installer')
if has_lspinstall then
  lspinstall.setup({
    -- ensure_installed = { 'sumneko_lua', 'golangci_lint_ls', 'gopls', 'html', 'json', 'tsserver', 'pyright', 'jdtls', 'rust_analyzer', 'dockerls' },
    ensure_installed = { 'sumneko_lua', 'golangci_lint_ls', 'gopls', 'html', 'json', 'tsserver', 'pyright' },
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

-- local configs = { 'cmp', 'metals', 'dap', 'golang', 'tsserver', 'html', 'pyright', 'luaserver', 'json', 'java', 'rust', 'docker' }
local configs = { 'cmp', 'metals', 'dap', 'golang', 'tsserver', 'html', 'luaserver', 'json', 'pyright' }
table.insert(configs, 'null-ls') -- add null-ls at the end

for _, config in ipairs(configs) do
  local ok, conf = pcall(require, 'lsp.' .. config)
  if ok then
    conf.setup(on_attach, capabilities)
  end
end
