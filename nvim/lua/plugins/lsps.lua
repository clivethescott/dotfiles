local map = vim.keymap.set
local on_attach = function(client, bufnr)
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

local setup_metals = function(capabilities)
  local has_metals, metals = pcall(require, 'metals')
  if not has_metals then
    return
  end
  local metals_config = metals.bare_config()
  -- NOTE: It's highly recommended to set your `statusBarProvider` to `on`. This
  -- enables `metals/status` and also other helpful messages that are shown to you
  metals_config.init_options.statusBarProvider = "on"
  metals_config.settings = {
    serverVersion = '1.0.1',
    fallbackScalaVersion = '3.3.0',
    showImplicitArguments = true,
    showImplicitConversionsAndClasses = false,
    showInferredType = true,
    serverProperties = { "-Xmx1G" },
    superMethodLensesEnabled = true,
    enableSemanticHighlighting = true,
    excludedPackages = {
      "akka.actor.typed.javadsl",
      "com.github.swagger.akka.javadsl"
    }
  }
  metals_config.capabilities = capabilities

  metals_config.on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    metals.setup_dap()
    -- other settings for metals here
  end

  local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "sc" },
    callback = function()
      if not os.getenv('NOMETALS') then
        metals.initialize_or_attach(metals_config)
      end
    end,
    group = nvim_metals_group,
  })
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
  local runtime_path = vim.split(package.path, ';', {})
  table.insert(runtime_path, 'lua/?.lua')
  table.insert(runtime_path, 'lua/?/init.lua')

  local library = {}

  local function add(lib)
    for _, p in pairs(vim.fn.expand(lib, false, true)) do
      p = vim.loop.fs_realpath(p)
      library[p] = true
    end
  end

  -- add runtime
  add("$VIMRUNTIME")

  -- add your config
  add("~/.config/nvim")

  -- add plugins
  -- if you're not using packer, then you might need to change the paths below

  add("~/.local/share/nvim/lazy/*")

  lspconfig.lua_ls.setup {
    -- delete root from workspace to make sure we don't trigger duplicate warnings
    on_new_config = function(config, root)
      local libs = vim.tbl_deep_extend("force", {}, library)
      libs[root] = nil
      config.settings.Lua.workspace.library = libs
      return config
    end,
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global and
          -- Luasnip shortcuts https://github.com/L3MON4D3/LuaSnip/blob/69cb81cf7490666890545fef905d31a414edc15b/lua/luasnip/config.lua#L82-L104
          globals = { 'vim', 'parse', 's', 'sn', 't', 'f', 'i', 'c', 'fmt', 'rep' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = library,
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
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    "folke/which-key.nvim",
    'nvim-telescope/telescope.nvim',
    "scalameta/nvim-metals",
  },
  config = function()
    local lspconfig = require 'lspconfig'
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

    require('mason').setup()

    local lsp_config_servers = { 'bufls', 'golangci_lint_ls', 'gopls', 'html', 'jsonls',
      'lua_ls', 'pyright', 'ruff_lsp', 'tsserver', 'terraformls', 'jdtls', }
    require 'mason-lspconfig'.setup({
      ensure_installed = lsp_config_servers
    })
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
    setup_metals(capabilities)
  end
}
