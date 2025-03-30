local launcher_path = vim.fs.joinpath(vim.fn.stdpath('config'), '/launchers/smithy-language-server')
return {
  name = 'smithy',
  cmd = { launcher_path },
  root_markers = { 'smithy-build.json' },
  filetype = { 'smithy' }
}
