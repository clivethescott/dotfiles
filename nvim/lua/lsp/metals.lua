local M = {}
M.setup = function(on_attach, capabilities)
  local has_metals, metals = pcall(require, 'metals')
  if not has_metals then
    return
  end
  local metals_config = metals.bare_config()
  -- NOTE: It's highly recommended to set your `statusBarProvider` to `on`. This
  -- enables `metals/status` and also other helpful messages that are shown to you
  metals_config.init_options.statusBarProvider = "on"
  metals_config.settings = {
    serverVersion = 'latest.snapshot',
    fallbackScalaVersion = '3.2.1',
    showImplicitArguments = true,
    showImplicitConversionsAndClasses = false,
    showInferredType = true,
    serverProperties = { "-Xmx1G" },
    superMethodLensesEnabled = true,
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
      -- Metals mappings
      metals.initialize_or_attach(metals_config)

    end,
    group = nvim_metals_group,
  })

end

return M
