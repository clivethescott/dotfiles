local M = {}
M.setup = function()
  local ok, lspconfig = pcall(require, 'lspconfig')
  if not ok then
    return
  end

  -- requires npm i -g vscode-langservers-extracted
  lspconfig.jsonls.setup {}
end

return M
