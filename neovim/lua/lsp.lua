local M = {}

-- Incremental selection is now supported via `textDocument/selectionRange`.
-- `an` selects outwards and `in` selects inwards.
-- e.g trigger with van, then an to expand/in to reduce

local supports_method = function(client, method, bufnr)
  if vim.fn.has('nvim-0.12') then
    return client:supports_method(method, bufnr)
  else
    return client:supports_method(method)
  end
end

local codelens = function(bufnr, au_group)
  vim.keymap.set('n', 'grl',
    function() vim.lsp.codelens.run() end, { buffer = true, desc = 'Run Codelens' })

  vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufEnter' }, {
    group = au_group,
    buffer = bufnr,
    desc = 'Refresh code lens for supported languages',
    callback = function()
      vim.lsp.codelens.refresh()
    end
  })
end

local formatting = function(client, bufnr)
  local conform_format = function()
    require 'conform'.format({
      timeout_ms = 2000,
      bufnr = bufnr or 0,
      async = false,
      lsp_format = "fallback",
      id = client.id,
    })
  end
  vim.keymap.set({ 'n', 'v' }, '<leader>f', conform_format, { buffer = true, desc = 'LSP Format' })
  vim.b.formatexpr = "v:lua.vim.lsp.formatexpr()"
end

local diagnostics = function(bufnr)
  vim.keymap.set('n', 'grq',
    function() vim.diagnostic.setqflist() end,
    { desc = 'LSP Diagnostics to qflist', buffer = bufnr })

  vim.keymap.set('n', '<leader>d',
    function() vim.diagnostic.open_float({ scope = 'line' }) end,
    { desc = 'Line Diagnostic', buffer = bufnr })

  vim.keymap.set('n', '[e',
    function()
      vim.diagnostic.jump {
        count = -1,
        wrap = false,
        severity = { min = vim.diagnostic.severity.WARN }
      }
    end, { desc = 'Prev Warning or Error', buffer = bufnr })

  vim.keymap.set('n', ']e',
    function()
      vim.diagnostic.jump {
        count = 1,
        wrap = true,
        severity = { min = vim.diagnostic.severity.WARN }
      }
    end,
    { desc = 'Next Warning or Error', buffer = bufnr })
end

function M.on_attach(client, bufnr)
  local lsp_group = vim.api.nvim_create_augroup('LspAttachedGroup', { clear = true })

  if client.name == 'copilot' then return end

  -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
  -- seems that Neovim does not pick up on gopls' semantic token support
  if client.name == 'gopls' and not client.server_capabilities.semanticTokensProvider then
    local semantic = client.config.capabilities.textDocument.semanticTokens
    client.server_capabilities.semanticTokensProvider = {
      full = true,
      legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
      range = true,
    }
  end

  -- Prefer LSP folding if client supports it
  -- :h vim.lsp.foldexpr
  if supports_method(client, 'textDocument/foldingRange', bufnr) then
    local win = vim.api.nvim_get_current_win()
    vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
  end

  if supports_method(client, 'textDocument/completion', bufnr) then
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = false })
  end


  if supports_method(client, 'textDocument/signatureHelp', bufnr) then
    vim.keymap.set({ 'n', 'i' }, '<M-s>', vim.lsp.buf.signature_help, { buffer = true, desc = 'Signature help' })
    -- default vim.keymap.set('i', '<c-s>',vim.lsp.buf.signature_help)
  end


  if supports_method(client, 'textDocument/rename', bufnr) then
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = true, desc = 'LSP Rename' })
    -- default vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
  end

  if supports_method(client, 'textDocument/declaration', bufnr) then
    vim.keymap.set('n', 'grd', function()
      if vim.g.use_picker == 'snacks.picker' then
        require 'snacks'.picker.lsp_declarations()
      elseif vim.g.use_picker == 'fzf-lua' then
        require 'fzf-lua'.lsp_declarations()
      end
    end, { buffer = true, desc = 'LSP Declaration' })
  elseif supports_method(client, 'textDocument/definition', bufnr) then
    -- default vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition)
    vim.keymap.set('n', 'gry', function()
      if vim.g.use_picker == 'snacks.picker' then
        require 'snacks'.picker.lsp_definitions()
      elseif vim.g.use_picker == 'fzf-lua' then
        require 'fzf-lua'.lsp_definitions()
      end
    end, { buffer = true, desc = 'LSP Definition' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true, silent = true })
  else
  end

  if supports_method(client, 'textDocument/inlayHint', bufnr) then
    vim.keymap.set({ 'n', 'i' }, '<M-i>',
      function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end, { desc = 'Toggle inlay hints' })

    vim.keymap.set('n', '<space>li', function()
      if vim.lsp.inlay_hint.is_enabled() then
        local virt_text = require 'utils'.get_inlay_hint(bufnr)
        if virt_text then
          vim.fn.setreg(vim.v.register, virt_text)
        end
      else
        vim.notify('Inlay hints are disabled', vim.log.levels.WARN)
      end
    end, { desc = 'Copy inlay hint', buffer = bufnr })
  end


  if supports_method(client, 'textDocument/references', bufnr) then
    -- default vim.keymap.set('n', 'grr', vim.lsp.buf.references)
    vim.keymap.set('n', 'gRr', function()
      if vim.g.use_picker == 'snacks.picker' then
        require 'snacks'.picker.lsp_references { includeDeclaration = false }
      elseif vim.g.use_picker == 'fzf-lua' then
        require 'fzf-lua'.lsp_references { includeDeclaration = false }
      end
    end, { buffer = true, desc = 'LSP References' })
  end

  if supports_method(client, 'textDocument/codeLens', bufnr) then
    codelens(bufnr, lsp_group)
  end

  local has_conform, _ = pcall(require, 'conform') -- has LSP as fallback
  if has_conform then
    vim.b.formatexpr = "v:lua.require'conform'.formatexpr()"
  end
  if supports_method(client, "textDocument/formatting", bufnr) or has_conform then
    formatting(client, bufnr)
  end
  if supports_method(client, "textDocument/diagnostic", bufnr) or client.name == "metals" then
    diagnostics(bufnr)
  end
end

function M.client_capabilities()
  local has_blink, blink = pcall(require, 'blink.cmp')

  local capabilities     = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      },
      semanticTokens = {
        multilineTokenSupport = true,
      },
      completionitem = {
        snippetSupport = true,
        resolveSupport = {
          properties = { "documentation", "detail", "additionalTextEdits" }
        }
      }
    }
  }
  if has_blink then
    capabilities = blink.get_lsp_capabilities(capabilities)
  else
    capabilities = vim.tbl_deep_extend('force', capabilities, vim.lsp.protocol.make_client_capabilities())
  end

  return capabilities
end

return M
