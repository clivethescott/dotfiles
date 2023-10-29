return {
  'scalameta/nvim-metals',
  ft = 'scala',
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local lsp = require'conf.lsp'
    local capabilities = lsp.capabilities()
    local metals = require'metals'
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
      lsp.on_attach(client, bufnr)
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
}
