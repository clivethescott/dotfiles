local setup_go = function(capabilities)
  require 'lspconfig'.gopls.setup {
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

local setup_python = function(capabilities)
  require 'lspconfig'.ruff.setup {
    capabilities = capabilities,
    -- settings = {
    -- }
  }
  require 'lspconfig'.pyright.setup {
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

local setup_tsserver = function(capabilities)
  require 'lspconfig'.ts_ls.setup {
    capabilities = capabilities,
    root_dir = require 'lspconfig'.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json'),
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

local setup_luaserver = function(capabilities)
  require 'lspconfig'.lua_ls.setup {
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT'
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global and
          -- Luasnip shortcuts https://github.com/L3MON4D3/LuaSnip/blob/69cb81cf7490666890545fef905d31a414edc15b/lua/luasnip/config.lua#L82-L104
          globals = { 'vim', 'parse', 's', 'sn', 't', 'f', 'i', 'c', 'fmt', 'rep' },
        },
        telemetry = {
          enable = false,
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            -- Depending on the usage, you might want to add additional paths here.
            "${3rd}/luv/library"
            -- "${3rd}/busted/library",
          }
        }
      },
    },
  }
end

local setup_ocaml = function(capabilities)
  require 'lspconfig'.ocamllsp.setup {
    capabilities = capabilities,
  }
end

local mk_capabilities = function()
  local server_capabilities = vim.lsp.protocol.make_client_capabilities()
  -- nvim ufo
  server_capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }
  server_capabilities.textDocument.completion.completionItem.snippetSupport = true -- broadcasting snippet capability for completion

  server_capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }
  local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  if has_cmp then
    -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
    server_capabilities = cmp_lsp.default_capabilities()
  end
  return server_capabilities
end

return {
  'neovim/nvim-lspconfig',
  event = 'BufReadPost',
  -- event = 'VeryLazy', causes an issue where LspAttach is not called if opening files directly
  dependencies = {
    'williamboman/mason.nvim',
  },
  config = function()
    local lsp_group = vim.api.nvim_create_augroup('LspAttachGroup', { clear = true })

    vim.api.nvim_create_autocmd({ "LspAttach" }, {
      group = lsp_group,
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
          -- if client.server_capabilities.inlayHintProvider then
          --   vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          -- end
          require 'lsp'.on_attach(client, bufnr)
        end
      end,
    })

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

    setup_go(capabilities)
    setup_python(capabilities)
    setup_tsserver(capabilities)
    setup_luaserver(capabilities)
    setup_ocaml(capabilities)
  end
}
