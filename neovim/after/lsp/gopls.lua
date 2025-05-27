return {
  filetypes = { 'go' },
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      semanticTokens = true,
      experimentalPostfixCompletions = true,
      analyses = {
        unusedvariable = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
  init_options = {
    usePlaceholders = false,
  },
}
