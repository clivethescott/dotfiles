---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.jsonls
  settings = {
    json = {
      -- https://github.com/SchemaStore/schemastore/blob/master/src/api/json/catalog.json
      schemas = require('schemastore').json.schemas {
        select = {
          "openapi.json",
          "gRPC API Gateway & OpenAPI Config",
          "Claude Code Settings",
          "AWS CloudFormation",
          "AWS CloudFormation Serverless Application Model (SAM)",
          "Golangci-lint Configuration",
        },
      },
      validate = { enable = true },
    },
  },
}
