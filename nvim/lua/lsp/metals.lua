local M = {}
M.setup = function(on_attach, capabilities)
  local has_telescope, telescope = pcall(require, 'telescope')
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
  metals_config.capabilities = capabilities

  metals_config.on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    metals.setup_dap()
    -- other settings for metals here

    local opts = { silent = true, noremap = true }
    -- Metals mappings
    if has_telescope then
      map('n', '<leader>c', telescope.extensions.metals.commands, opts)
      --[[ Depending on what you're using to display these results, some send in an empty query string to start off the process.
  Since this can potentially be a huge amount of symbols, metals won't respond to an empty query search.
  So for example with telescope, I need to use builtin.lsp_dynamic_workspace_symbols not the normal builtin.lsp_workspace_symbols ]]
      map('n', '<space>wS', telescope.lsp_dynamic_workspace_symbols, opts)

    end
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
