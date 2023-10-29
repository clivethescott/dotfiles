local lsp = require'conf.lsp'
local on_attach = lsp.on_attach
local capabilities = lsp.capabilities()

local setup_go = function(lspconfig, capabilities)
  lspconfig.gopls.setup {
    capabilities = capabilities,
    filetypes = { 'go' },
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end,
    settings = {
      gopls = {
        semanticTokens = true,
        codelenses = {
          generate = true,
        },
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
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

local setup_rust = function(capabilities)
  require 'lspconfig'.rust_analyzer.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end,
  }
end

local setup_python = function(lspconfig, capabilities)
  lspconfig.pyright.setup {
    capabilities = capabilities,
    on_attach = on_attach,
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
  lspconfig.tsserver.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json')
  }
end

local setup_luaserver = function(lspconfig, capabilities)
  lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace"
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

return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    'williamboman/mason.nvim',
    "folke/which-key.nvim",
  },
  config = function()
    local lspconfig = require 'lspconfig'
    local lsp = require 'conf.lsp'
    local capabilities = lsp.capabilities()

    -- No extra config required, just run setup for these
    require 'lspconfig'.dockerls.setup {}
    require 'lspconfig'.bufls.setup {}
    require 'lspconfig'.graphql.setup {}
    require 'lspconfig'.html.setup {
      capabilities = capabilities
    }
    require 'lspconfig'.jsonls.setup {}
    require 'lspconfig'.rust_analyzer.setup {}
    require 'lspconfig'.yamlls.setup {
      settings = {
        yaml = { keyOrdering = false },
      }
    }
    require 'lspconfig'.terraformls.setup {}
    setup_go(lspconfig, capabilities)
    setup_python(lspconfig, capabilities)
    setup_tsserver(lspconfig, capabilities)
    setup_luaserver(lspconfig, capabilities)
    setup_rust(capabilities)
  end
}
