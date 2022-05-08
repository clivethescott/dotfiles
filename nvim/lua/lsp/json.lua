local M = {}
M.setup = function()
  local ok, lspconfig = pcall(require, 'lspconfig')
  if not ok then
    return
  end

  lspconfig.jsonls.setup {}
end

return M
