vim.api.nvim_create_user_command('GitBlame', function()
  require 'helper.utils'.gitBlame()
end, {})

vim.api.nvim_create_user_command('GitBlameClear', function()
  require 'helper.utils'.gitBlameClear()
end, {})

vim.api.nvim_create_user_command('LspStatus', function()
  require 'helper.utils'.resolvedCapabilities()
end, {})

vim.api.nvim_create_user_command('GoImports', function()
  if vim.fn.executable('goimports') then
    vim.cmd('!goimports -w %')
  end
end, {})

vim.api.nvim_create_user_command('AlternateFile', function()
  local ext = vim.fn.expand('%:e')
  if ext == 'go' then
    require 'helper.utils'.alt_go_file()
  elseif ext == 'scala' then
    require 'helper.utils'.alt_scala_file()
  end
end, {})
