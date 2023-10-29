local M = {}
local map = vim.keymap.set

function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true   -- broadcasting snippet capability for completion
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }
  local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  if has_cmp then
    -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
    capabilities = cmp_lsp.default_capabilities()
  end
end

function M.on_attach(client, bufnr)
  -- vim.notify('LSP connected client ' .. client.name, 'info')
  local utils = require 'helper.utils'
  local telescope_builtin = require 'telescope.builtin'
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

  -- Formatting

  if caps.documentFormattingProvider then
    map('n', '<leader>f', utils.lsp_buf_format, opts)
    map('n', 'gq', utils.lsp_buf_format, opts)
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
  local open_diagnostic_float = function()
    vim.diagnostic.open_float({ scope = 'line' }) -- can be line, buffer, cursor
  end
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
  local lsp_references = function()
    telescope_builtin.lsp_references {
      include_declaration = false
    }
  end

  wk.register({
    ["["] = {
      name = '+Previous',
      e = { prev_diagnostic, 'Diagnostic' },
    },
    ["]"] = {
      name = '+Next',
      e = { vim.diagnostic.goto_next, 'Diagnostic' },
    },
    ["<leader>r"] = { vim.lsp.buf.rename, 'Refactor Rename' },
    ["®"] = { vim.lsp.buf.rename, 'Refactor Rename' },
    ["<leader>d"] = { open_diagnostic_float, 'Open Diagnostic Float' },
    ["<leader>D"] = { telescope_builtin.diagnostics, 'Diagnostics' },
    ["<space>"] = {
      l = {
        name = '+LSP',
        e = { diagnostic_errors, 'Workspace Errors' },
        w = { diagnostic_warnings, 'Workspace Warnings' },
        s = { telescope_builtin.lsp_dynamic_workspace_symbols, 'Dynamic Workspace Symbols' },
        S = { telescope_builtin.lsp_document_symbols, 'Buffer Symbols' },
      }
    },
    g = {
      name = '+GoTo',
      ["["] = { prev_diagnostic, 'Prev Diagnostic' },
      ["]"] = { vim.diagnostic.goto_next, 'Next Diagnostic' },
      a = { vim.lsp.buf.code_action, 'Code Action' },
      d = { telescope_builtin.lsp_definitions, 'Definition <Telescope>' },
      D = { '<cmd>Trouble lsp_definitions<cr>', 'Definition <Trouble>' },
      h = { utils.show_word_help, 'Word Help' },
      i = { telescope_builtin.lsp_implementations, 'Implementation' },
      l = { vim.lsp.codelens.run, 'Show Code Lens' },
      m = { vim.lsp.codelens.refresh, 'Refresh Code Lens' },
      r = { lsp_references, 'References <Telescope>' },
      R = { '<cmd>Trouble lsp_references<cr>', 'References <Trouble>' },
      s = { vim.lsp.buf.signature_help, 'Signature Help' },
      y = { telescope_builtin.lsp_type_definitions, 'Type Def' },
    },
    K = { vim.lsp.buf.hover, 'Hover' },
  }, wk_buf_opts)
end

return M
