vim.api.nvim_create_user_command('GitBlame', function()
  require 'helper.utils'.gitBlame()
end, {})

vim.api.nvim_create_user_command('GitBlameClear', function()
  require 'helper.utils'.gitBlameClear()
end, {})

vim.api.nvim_create_user_command('LspStatus', function()
  require 'helper.utils'.resolvedCapabilities()
end, {})

local get_ftype = function(bufnr)
  return vim.fn.getbufvar(bufnr or 0, '&filetype')
end

vim.api.nvim_create_user_command('AlternateFile', function()
  local ft = get_ftype()
  if ft == 'go' then
    require 'helper.utils'.alt_go_file()
  elseif ft == 'scala' then
    require 'helper.utils'.alt_scala_file()
  end
end, {})
