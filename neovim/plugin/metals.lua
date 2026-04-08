vim.pack.add({ { src = 'https://github.com/nvim-lua/plenary.nvim', version = 'master' } })
vim.pack.add({ { src = 'https://github.com/scalameta/nvim-metals', version = 'main' } })

local metals = require 'metals'
local metals_config = metals.bare_config()
metals_config.init_options.statusBarProvider = "off"   -- use fidget
metals_config.inlayHints = {
  typeParameters = {
    enable = true
  },
  hintsInPatternMatch = {
    enable = true,
  },
  ['named-parameters'] = {
    enable = true,
  },
}
metals_config.settings = {
  disabledMode = true,
  -- disabledMode = vim.env.METALS == '0',
  -- startMcpServer = false,
  -- serverVersion = '1.6.5',
  serverVersion = '2.0.0-M8',
  startMcpServer = false,   -- https://scalameta.org/metals/blog/#standalone-mcp-server
  fallbackScalaVersion = '2.13.16',
  showImplicitArguments = true,
  showImplicitConversionsAndClasses = true,
  showInferredType = true,
  serverProperties = { "-Xmx4G", "-Xms1G" },
  superMethodLensesEnabled = false,
  -- worksheetScreenWidth = 120,
  enableBestEffort = true,
  enableSemanticHighlighting = true,
  excludedPackages = {
    "akka.actor.typed.javadsl",
    "com.github.swagger.akka.javadsl"
  },
  testUserInterface = "Test Explorer",
  autoImportBuild = 'all',
  defaultBspToBuildTool = true,
  inlayHints = {
    byNameParameters = { enable = false },
    hintsInPatternMatch = { enable = true },
    implicitArguments = { enable = true },
    implicitConversions = { enable = false },
    inferredTypes = { enable = true },
    typeParameters = { enable = false },
  }
}
metals_config.capabilities = require 'lsp'.client_capabilities()

metals_config.on_attach = function(client, bufnr)
  -- client and bufnr will be used in lspconfig
  local dap_enabled = false   -- TODO: setup DAP if needed
  if dap_enabled then
    metals.setup_dap()
  end
  -- other settings for metals here
  require 'lsp'.on_attach(client, bufnr)

  vim.keymap.set('n', '<space>mo', metals.hover_worksheet,
    { desc = 'Hover worksheet', buffer = bufnr })
end

local metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { 'scala', 'sbt', 'java' },
  callback = function()
    metals.initialize_or_attach(metals_config)
  end,
  group = metals_group,
})

-- worksheets use inlay_hints to show results
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.worksheet.sc" },
  callback = function()
    vim.lsp.inlay_hint.enable(true)
  end,
  group = metals_group,
})
