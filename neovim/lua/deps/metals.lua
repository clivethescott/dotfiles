return {
  'scalameta/nvim-metals',
  ft = 'scala',
  cond = vim.env.METALS ~= 'false',
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local metals = require 'metals'
    local metals_config = metals.bare_config()
    metals_config.init_options.statusBarProvider = "off" -- use fidget
    metals_config.inlayHints = {
      typeParameters = {
        enable = true
      },
      hintsInPatternMatch = {
        enable = true,
      }
    }
    metals_config.settings = {
      serverVersion = '1.6.0',
      fallbackScalaVersion = '3.6.3',
      showImplicitArguments = true,
      showImplicitConversionsAndClasses = true,
      showInferredType = true,
      serverProperties = { "-Xmx4G", "-Xms1G" },
      superMethodLensesEnabled = false,
      enableSemanticHighlighting = true,
      excludedPackages = {
        "akka.actor.typed.javadsl",
        "com.github.swagger.akka.javadsl"
      },
      testUserInterface = "Test Explorer",
      autoImportBuild = 'all',
      defaultBspToBuildTool = true,
      -- inlayHints = {
      --   byNameParameters = { enable = true },
      --   hintsInPatternMatch = { enable = true },
      --   implicitArguments = { enable = true },
      --   implicitConversions = { enable = true },
      --   inferredTypes = { enable = true },
      --   typeParameters = { enable = true },
      -- }
    }
    metals_config.capabilities = require 'lsp'.client_capabilities()

    metals_config.on_attach = function(client, bufnr)
      -- client and bufnr will be used in lspconfig
      local dap_enabled = false -- TODO: setup DAP if needed
      if dap_enabled then
        metals.setup_dap()
      end
      -- other settings for metals here
      require 'lsp'.on_attach(client, bufnr)

      vim.keymap.set('n', '<space>mo', metals.hover_worksheet,
        { desc = 'Hover worksheet', buffer = bufnr })

    end

    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "scala", "sbt", "sc" },
      callback = function()
        metals.initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end
}
