local util = require 'vim.lsp.util'

M = {}
M.implementation = function()
  local params = util.make_position_params()
  vim.lsp.buf_request(0, "textDocument/references", params, function(_, result, ctx, config)
    if not result or vim.tbl_isempty(result) then
      vim.notify('No references found')
    else
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      config = config or {}
      if config.loclist then
        vim.fn.setloclist(0, {}, ' ', {
          title = 'References';
          items = util.locations_to_items(result, client.offset_encoding);
          context = ctx;
        })
        vim.api.nvim_command("lopen")
      else
        vim.fn.setqflist({}, ' ', {
          title = 'References';
          items = util.locations_to_items(result, client.offset_encoding);
          context = ctx;
        })
      end
    end
  end)
end

return M
