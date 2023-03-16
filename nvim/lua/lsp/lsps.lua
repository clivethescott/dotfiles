-- LSP settings
local map = vim.keymap.set
local has_telescope, telescope_builtin = pcall(require, 'telescope.builtin')
local utils = require 'helper.utils'

local on_attach = function(client, bufnr)
  -- vim.notify('LSP connected client ' .. client.name, 'info')
  local opts = { buffer = bufnr, silent = true }
  local caps = client.server_capabilities
  local wk = require 'which-key'
  local wk_buf_opts = {
    mode = "n",
    prefix = "",
    buffer = bufnr,
    silent = true,
    noremap = true,
    nowait = false,
  }

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

    wk.register({
      g = {
        d = { telescope_builtin.lsp_definitions, 'Go To Definition' },
        i = { telescope_builtin.lsp_implementations, 'Go To Implementation' },
        r = { telescope_builtin.lsp_references, 'Go To References' },
        y = { telescope_builtin.lsp_type_definitions, 'Go To TypeDef' },
      },
      ["<space>"] = {
        w = {
          s = { telescope_builtin.lsp_dynamic_workspace_symbols, 'Dynamic Workspace Symbols' },
          S = { telescope_builtin.lsp_document_symbols, 'Buffer Symbols' },
        }
      },
      ["<leader>"] = {
        D = { telescope_builtin.diagnostics, 'Diagnostics' },
      }
    }, wk_buf_opts)
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

  wk.register({
    g = {
      a = { vim.lsp.buf.code_action, 'Code Action' },
      D = { vim.lsp.buf.declaration, 'Go To Declaration' },
      h = { utils.show_word_help, 'Show Word Help' },
      l = { vim.lsp.codelens.run, 'Show Code Lens' },
      s = { vim.lsp.buf.signature_help, 'Signature Help' },
    },
    K = { vim.lsp.buf.hover, 'Hover' },
    ["<leader>r"] = { vim.lsp.buf.rename, 'Refactor Rename' },
  }, wk_buf_opts)
  -- Formatting

  if caps.documentFormattingProvider then
    map('n', '<leader>f', utils.lsp_buf_format, opts)
    wk.register({
      ["<leader>f"] = { utils.lsp_buf_format, 'Format Buffer' },
    }, wk_buf_opts)
  end

  if caps.documentRangeFormattingProvider then
    map('v', '<leader>f', utils.lsp_range_format, opts)
  end

  -- Diagnostics
  local prev_diagnostic = function()
    -- prevent previous jumping back
    vim.diagnostic.goto_prev { wrap = false }
  end
  map('n', 'g[', prev_diagnostic, opts)
  map('n', 'g]', vim.diagnostic.goto_next, opts)
  local open_diagnostic_float = function()
    vim.diagnostic.open_float({ scope = 'line' }) -- can be line, buffer, cursor
  end
  map('n', '<leader>d', open_diagnostic_float, opts)
  -- map('n', '<leader>d', vim.diagnostic.setloclist, opts) -- buffer diagnostics only

  -- map('n', '/leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  -- map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  -- map('n', '<leader>wl', function()
  --   vim.inspect(vim.lsp.buf.list_workspace_folders())
  -- end, opts)
  local diagnostic_errors = function()
    vim.diagnostic.setqflist({ severity = 'E' }) -- all workspace errors
  end
  local diagnostic_warnings = function()
    vim.diagnostic.setqflist({ severity = 'W' }) -- all workspace errors
  end
  map('n', '<space>we', diagnostic_errors, opts)
  map('n', '<space>ww', diagnostic_warnings, opts)

  wk.register({
    g = {
      ["["] = { prev_diagnostic, 'Go To Prev Diagnostic' },
      ["]"] = { vim.diagnostic.goto_super_method, 'Go To Next Diagnostic' },
    },
    ["<leader>d"] = { open_diagnostic_float, 'Open Diagnostic Float' },
    ["<space>"] = {
      w = {
        e = { diagnostic_errors, 'Workspace Errors' },
        w = { diagnostic_warnings, 'Workspace Warnings' },
      }
    }
  }, wk_buf_opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true -- broadcasting snippet capability for completion
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}
local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if has_cmp then
  -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
  capabilities = cmp_lsp.default_capabilities()
end

-- Setup mason so it can manage external tooling
require('mason').setup()

require 'mason-lspconfig'.setup({
  -- ensure_installed = { 'sumneko_lua', 'golangci_lint_ls', 'gopls', 'html', 'json', 'tsserver', 'pyright', 'jdtls', 'rust_analyzer', 'dockerls' },
  ensure_installed = { 'lua_ls', 'golangci_lint_ls', 'gopls', 'html', 'jsonls', 'tsserver', 'pyright',
    'rust_analyzer' },
})

local setup_servers = { 'cmp', 'metals', 'dap', 'golang', 'tsserver', 'html', 'luaserver', 'json', 'pyright', 'rust' }
table.insert(setup_servers, 'null-ls') -- add null-ls at the end

for _, setup_server in ipairs(setup_servers) do
  local ok, server = pcall(require, 'lsp.' .. setup_server)
  if ok then
    server.setup(on_attach, capabilities)
  end
end

require 'lspconfig'.dockerls.setup {}
require('lspconfig').yamlls.setup {}
