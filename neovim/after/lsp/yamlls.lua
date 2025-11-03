return {
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
      schemas = require("schemastore").yaml.schemas(),
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
