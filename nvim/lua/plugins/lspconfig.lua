local on_attach = function(client, bufnr)
  local map = vim.keymap.set
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

  -- Formatting

  -- alt to gs
  map({ 'n', 'i' }, '<M-y>', vim.lsp.buf.signature_help)

  if caps.documentFormattingProvider then
    map('n', '<leader>f', utils.lsp_buf_format, opts)
    map('n', 'gq', utils.lsp_buf_format, opts)
    wk.add({
      { "<leader>f", utils.lsp_buf_format, desc = 'Format Buffer' },
    }, wk_buf_opts)
  end

  if caps.documentRangeFormattingProvider then
    map('v', '<leader>f', utils.lsp_range_format, opts)
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
    -- TODO: use others like incoming/outgoing refs?
    telescope_builtin.lsp_references {
      include_declaration = false
    }
  end

  local code_lens_run = function()
    if client.server_capabilities.codeLensProvider then
      if client.name == 'rust_analyzer' then
        vim.cmd.RustLsp('hover')
      else
        vim.lsp.codelens.run()
      end
    end
  end

  wk.add({
    {
      "[e",
      function()
        vim.diagnostic.goto_prev {
          wrap = false,
          severity = { min = vim.diagnostic.severity.WARN }
        }
      end,
      desc = 'Previous Warning or Error'
    },
    {
      "]e",
      function()
        vim.diagnostic.goto_next {
          wrap = false,
          severity = { min = vim.diagnostic.severity.WARN }
        }
      end,
      desc = 'Next Warning or Error'
    },
    { "<leader>r", vim.lsp.buf.rename,            desc = 'Refactor Rename' },
    { "®",         vim.lsp.buf.rename,            desc = 'Refactor Rename' },
    { "<leader>d", open_diagnostic_float,         desc = 'Open Diagnostic Float' },
    -- ["<C-w>d"] = { open_diagnostic_float, 'Open Diagnostic Float' }, -- nvim default
    -- ["<C-w><C-d>"] = { open_diagnostic_float, 'Open Diagnostic Float' }, -- nvim default
    { "<leader>D", telescope_builtin.diagnostics, desc = 'Diagnostics' },
    {
      group = '+LSP',
      { "<space>le",  diagnostic_errors,    desc = 'Workspace Errors' },
      { "<space>lrs", utils.restart_smithy, desc = 'Restart Smithy' },
      {
        "<space>lrs",
        function() require 'metals'.restart_metals() end,
        desc = 'Restart Metals'
      },
      {
        "<space>ls",
        telescope_builtin.lsp_dynamic_workspace_symbols,
        desc = 'Dynamic Workspace Symbols'
      },
      {
        "<space>lS",
        telescope_builtin.lsp_document_symbols,
        desc = 'Buffer Symbols'
      },
      { "<space>lw", diagnostic_warnings, desc = 'Workspace Warnings' },
    },
    {
      group = '+GoTo',
      {
        "ga",
        vim.lsp.buf.code_action,
        desc = 'Code Action'
      },
      {
        "gd",
        function()
          if client.name == 'lua_ls' then
            telescope_builtin.lsp_type_definitions()
          else
            telescope_builtin.lsp_definitions()
          end
        end,
        desc = 'Definition <Telescope>'
      },
      { "gD", '<cmd>Trouble lsp_definitions<cr>',    desc = 'Definition <Trouble>' },
      { "gh", utils.show_word_help,                  desc = 'Word Help' },
      { "gi", telescope_builtin.lsp_implementations, desc = 'Implementation' },
      { "gl", code_lens_run,                         desc = 'Show Code Lens' },
      {
        "gm",
        function() vim.lsp.codelens.refresh { bufnr = 0 } end,
        desc = 'Refresh Code Lens'
      },
      { "gr", lsp_references,                         desc = 'References <Telescope>' },
      { "gR", '<cmd>Trouble lsp_references<cr>',      desc = 'References <Trouble>' },
      { "gy", telescope_builtin.lsp_type_definitions, desc = 'Type Def' },
    },
    { "K", vim.lsp.buf.hover, desc = 'Hover' }, -- nvim default
  }, wk_buf_opts)
end

local setup_go = function(lspconfig, capabilities)
  lspconfig.gopls.setup {
    capabilities = capabilities,
    filetypes = { 'go' },
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        experimentalPostfixCompletions = true,
        analyses = {
          unusedvariable = true,
        },
        staticcheck = true,
        gofumpt = true,
      },
    },
    init_options = {
      usePlaceholders = false,
    },
  }
end

local setup_python = function(lspconfig, capabilities)
  lspconfig.ruff.setup {
    capabilities = capabilities,
    -- settings = {
    -- }
  }
  lspconfig.pyright.setup {
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          loglevel = 'Error',
          typeCheckingMode = 'strict'
        }
      }
    }
  }
end

local setup_tsserver = function(lspconfig, capabilities)
  lspconfig.ts_ls.setup {
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json'),
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        }
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        }
      }
    },
  }
end

local setup_luaserver = function(lspconfig, capabilities)
  lspconfig.lua_ls.setup {
    capabilities = capabilities,
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
          postfix = true,
        },
        hint = {
          enable = true,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global and
          -- Luasnip shortcuts https://github.com/L3MON4D3/LuaSnip/blob/69cb81cf7490666890545fef905d31a414edc15b/lua/luasnip/config.lua#L82-L104
          globals = { 'vim', 'parse', 's', 'sn', 't', 'f', 'i', 'c', 'fmt', 'rep' },
        },
        workspace = {
          maxPreload = 2000,
          preloadFileSize = 50000,
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

local setup_ocaml = function(lspconfig, capabilities)
  lspconfig.ocamllsp.setup {
    capabilities = capabilities,
  }
end

local mk_capabilities = function()
  local caps = vim.lsp.protocol.make_client_capabilities()
  -- nvim ufo
  caps.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }
  caps.textDocument.completion.completionItem.snippetSupport = true -- broadcasting snippet capability for completion

  caps.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }
  local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  if has_cmp then
    -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
    caps = cmp_lsp.default_capabilities()
  end
  return caps
end

return {
  'neovim/nvim-lspconfig',
  event = 'BufReadPost',
  -- event = 'VeryLazy', causes an issue where LspAttach is not called if opening files directly
  dependencies = {
    'williamboman/mason.nvim',
    "folke/which-key.nvim",
  },
  config = function()
    local lsp_group = vim.api.nvim_create_augroup('LspActionsGroup', { clear = true })

    vim.api.nvim_create_autocmd({ "LspAttach" }, {
      group = lsp_group,
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
          -- if client.server_capabilities.inlayHintProvider then
          --   vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          -- end
          on_attach(client, bufnr)

          vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufEnter' }, {
            group = lsp_group,
            pattern = { '*.rust', '*.go', '*.python' },
            desc = 'Refresh code lens for supported languages',
            callback = function()
              if client.server_capabilities.codeLensProvider then
                vim.lsp.codelens.refresh()
              end
            end
          })
        end
      end,
    })

    local lspconfig = require 'lspconfig'
    local capabilities = mk_capabilities()

    -- No extra config required, just run setup for these
    require 'lspconfig'.dockerls.setup {}
    require 'lspconfig'.buf_ls.setup {}
    require 'lspconfig'.graphql.setup {}
    require 'lspconfig'.html.setup {
      capabilities = capabilities
    }
    require 'lspconfig'.jsonls.setup {}
    require 'lspconfig'.yamlls.setup {
      settings = {
        yaml = {
          keyOrdering = false,
          format = {
            enable = true,
          },
          hover = true,
          completion = true,
          customTags = {
            "!fn",
            "!And",
            "!If",
            "!Not",
            "!Equals",
            "!Or",
            "!FindInMap sequence",
            "!Base64",
            "!Cidr",
            "!Ref",
            "!Ref Scalar",
            "!Sub",
            "!GetAtt",
            "!GetAZs",
            "!ImportValue",
            "!Select",
            "!Split",
            "!Join sequence"
          },
        },
      }
    }
    require 'lspconfig'.terraformls.setup {}
    require 'lspconfig'.hls.setup {
      filetypes = { 'haskell', 'lhaskell', 'cabal' },
    }
    require 'lspconfig'.jdtls.setup {}

    setup_go(lspconfig, capabilities)
    setup_python(lspconfig, capabilities)
    setup_tsserver(lspconfig, capabilities)
    setup_luaserver(lspconfig, capabilities)
    setup_ocaml(lspconfig, capabilities)
  end
}
