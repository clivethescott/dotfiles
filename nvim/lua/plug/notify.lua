local ok, notify = pcall(require, 'notify')
if not ok then
  return
end

notify.setup({
  timeout = 1000,
})
vim.notify = notify
