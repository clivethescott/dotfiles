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
    require 'lspconfig'.dockerls.setup {}
    require 'lspconfig'.buf_ls.setup {}
    require 'lspconfig'.graphql.setup {}
    require 'lspconfig'.html.setup {}
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
    require 'lspconfig'.rust_analyzer.setup {
      -- toolchain installs a wrapper that isn't the real binary
      cmd = { 'rust-analyzer' },
      settings = {
        ['rust-analyzer'] = {
          diagnostics = { -- example
            enable = true,
          }
        }
      }
    }

    require 'lspconfig'.gopls.setup {
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
          semanticTokens = true,
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
    require 'lspconfig'.ruff.setup {}
    require 'lspconfig'.pyright.setup {
      settings = {
        python = {
          analysis = {
            loglevel = 'Error',
            typeCheckingMode = 'strict'
          }
        }
      }
    }
    require 'lspconfig'.ts_ls.setup {
      root_dir = require 'lspconfig'.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json'),
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
          }
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
          }
        }
      },
    }
    require 'lspconfig'.lua_ls.setup {
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

    local capabilities = require 'lsp'.client_capabilities()
    vim.lsp.config('*', { capabilities = capabilities })
  end
}
