local ok, dap_virt_text = pcall(require, 'nvim-dap-virtual-text')
if not ok then
  return
end

dap_virt_text.setup {
  enabled = true, -- enable this plugin (the default)
}

vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '🟦', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '⭐️', texthl = '', linehl = '', numhl = '' })
