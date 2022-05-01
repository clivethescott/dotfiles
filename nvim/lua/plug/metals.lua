local metals_config = require("metals").bare_config()
-- NOTE: It's highly recommended to set your `statusBarProvider` to `on`. This
-- enables `metals/status` and also other helpful messages that are shown to you
metals_config.init_options.statusBarProvider = "on"
metals_config.settings = {
  serverVersion = 'latest.snapshot',
  showImplicitArguments = true,
  showImplicitConversionsAndClasses = true,
  showInferredType = true,
  serverProperties = { "-Xmx1G" },
  superMethodLensesEnabled = true,
  excludedPackages = {
    "akka.actor.typed.javadsl",
    "com.github.swagger.akka.javadsl"
  }
}

-- Example if you are using cmp have to make sure the correct capabilities for snippets are set
local capabilities = vim.lsp.protocol.make_client_capabilities()
metals_config.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "sc" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
