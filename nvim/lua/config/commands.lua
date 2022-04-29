vim.api.nvim_create_user_command('GitBlame', function()
  require 'config.utils'.gitBlame()
end, {})

vim.api.nvim_create_user_command('GitBlameClear', function()
  require 'config.utils'.gitBlameClear()
end, {})

vim.api.nvim_create_user_command('LspStatus', function()
  require 'config.utils'.resolvedCapabilities()
end, {})
