local launcher_path = vim.fn.stdpath('config') .. '/launchers/smithy-language-server'
vim.print(launcher_path)
vim.lsp.start({
  name = 'smithy-language-server',
  cmd = { launcher_path }, -- see shell script for command
  root_dir = vim.fs.dirname(vim.fs.find({ 'smithy-build.json' }, { upward = false })[1]),
}, {
  reuse_client = true,
  init_options = {
    statusBarProvider = 'show-message',
    isHttpEnabled = true,
    compilerOptions = {
      snippetAutoIndent = false,
    },
  },
    on_attach = vim.notify("Smithy LSP started")
})
