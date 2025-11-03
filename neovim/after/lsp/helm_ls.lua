return {
  root_markers = { "Chart.yaml" },
  cmd = { "helm_ls", "serve" },
  settings = {
    ['helm-ls'] = {
      logLevel = "warn",
      valuesFiles = {
        mainValuesFile = "base_values.yaml",
        additionalValuesFilesGlobPattern = "(dev|qa|prod)-*.yaml"
      },
    }
  }
}
