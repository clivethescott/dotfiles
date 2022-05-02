local M = {}

function M.resolvedCapabilities(client_id)
  client_id = client_id or 1
  print(vim.inspect(vim.lsp.buf_get_clients()[client_id].server_capabilities))
end

function M.uuid()
  return string.lower(require'os'.execute("uuidgen | tr -d '\n'"))
end

return M
