vim.api.nvim_create_user_command('GitBlame', function()
  require 'helper.utils'.gitBlame()
end, {})

vim.api.nvim_create_user_command('GitBlameClear', function()
  require 'helper.utils'.gitBlameClear()
end, {})

vim.api.nvim_create_user_command('LspStatus', function()
  require 'helper.utils'.resolvedCapabilities()
end, {})
