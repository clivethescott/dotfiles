local schemas = {
  "Helm Chart.yaml",
  "Helm Unittest Test Suite",
  "AWS CloudFormation",
  "AWS CloudFormation Serverless Application Model (SAM)",
  "GitHub Action",
  "GitHub Workflow",
  "Golangci-lint Configuration",
  "Jekyll",
  "lazygit"
}
local extra_schemas = vim.g.is_work_pc and {
  {
    description = 'Mariner Helm values',
    fileMatch = '**/values/*.yaml',
    name = 'Mariner Helm values',
    url = vim.fs.joinpath(vim.env.HOME, "/IdeaProjects/Spinnaker/values.schema.json"),
  }
} or {}
if vim.g.is_work_pc then
  table.insert(schemas, "Mariner Helm values")
end

---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.yamlls
  settings = {
    redhat = {
      telemetry = {
        enabled = false
      }
    },
    yaml = {
      keyOrdering = false,
      format = {
        enable = true,
      },
      schemaStore = {
        -- disable built-in schemaStore support to use external
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      schemas = require("schemastore").yaml.schemas {
        extra = extra_schemas,
        select = schemas,
      },
      hover = true,
      completion = true,
      customTags = {
        "!fn",
        "!And",
        "!If",
        "!Not",
        "!Equals",
        "!Or",
        "!FindInMap sequence",
        "!Base64",
        "!Cidr",
        "!Ref",
        "!Ref Scalar",
        "!Sub",
        "!GetAtt",
        "!GetAZs",
        "!ImportValue",
        "!Select",
        "!Split",
        "!Join sequence"
      },
    },
  }
}
