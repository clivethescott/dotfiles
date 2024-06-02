vim.api.nvim_create_user_command('LspStatus', function()
  require 'helper.utils'.resolvedCapabilities()
end, {})

vim.api.nvim_create_user_command('GoImports', function()
  if vim.fn.executable('goimports') then
    vim.cmd('silent !goimports -w %')
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

vim.api.nvim_create_user_command('G', function()
  require 'neogit'.open({ kind = 'replace' })
end, {})

vim.api.nvim_create_user_command('Git', function()
  require 'neogit'.open({ kind = 'replace' })
end, {})


vim.api.nvim_create_user_command('SmithyRestart', function()
  require 'helper.utils'.restart_smithy()
end, {})

vim.api.nvim_create_user_command('QuickFixOpenAll', function()
  vim.cmd [[
      if empty(getqflist())
          return
      endif
      let s:prev_val = ""
      for d in getqflist()
          let s:curr_val = bufname(d.bufnr)
          if (s:curr_val != s:prev_val)
              exec "edit " . s:curr_val
          endif
          let s:prev_val = s:curr_val
      endfor
   ]]
end, {})
