vim.api.nvim_create_user_command('GitBlame', function()
 require'utils'.gitBlame()
end, {})

vim.api.nvim_create_user_command('GitBlameClear', function()
 require'utils'.gitBlameClear()
end, {})
