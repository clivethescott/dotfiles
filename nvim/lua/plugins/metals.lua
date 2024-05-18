return {
  'scalameta/nvim-metals',
  ft = 'scala',
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local metals = require 'metals'
    local metals_config = metals.bare_config()
    -- NOTE: It's highly recommended to set your `statusBarProvider` to `on`. This
    -- enables `metals/status` and also other helpful messages that are shown to you
    metals_config.init_options.statusBarProvider = "on"
    metals_config.inlayHints = {
      typeParameters = {
        enable = true
      },
      hintsInPatternMatch = {
        enable = true,
      }
    }
    metals_config.settings = {
      serverVersion = '1.3.1',
      fallbackScalaVersion = '3.3.3',
      showImplicitArguments = false,
      showImplicitConversionsAndClasses = true,
      showInferredType = true,
      serverProperties = { "-Xmx1G" },
      superMethodLensesEnabled = true,
      enableSemanticHighlighting = true,
      excludedPackages = {
        "akka.actor.typed.javadsl",
        "com.github.swagger.akka.javadsl"
      },
      testUserInterface = "Test Explorer",
      autoImportBuild = 'all',
      defaultBspToBuildTool = true,

    }
    metals_config.capabilities = require 'cmp_nvim_lsp'.default_capabilities()

    metals_config.on_attach = function()
      -- client and bufnr will be used in lspconfig
      local dap_enabled = require 'helper.utils'.plugin_conf().dap_enabled
      if dap_enabled then
        metals.setup_dap()
      end
      -- other settings for metals here
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
