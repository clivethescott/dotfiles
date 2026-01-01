return {
  'nvim-lspconfig',
  event = 'DeferredUIEnter', -- causes an issue where LspAttach is not called if opening files directly
  dependencies = {
    'mason.nvim',
    "schemastore.nvim",
  },
  after = function()
    local lsp_group = vim.api.nvim_create_augroup('LspAttachGroup', { clear = true })

    vim.api.nvim_create_autocmd({ "LspAttach" }, {
      group = lsp_group,
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
          -- if client.server_capabilities.inlayHintProvider then
          --   vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          -- end
          require 'lsp'.on_attach(client, bufnr)
        end
      end,
    })

    vim.lsp.enable({
      'graphql', 'html', 'jsonls', 'taplo', 'yamlls', 'ruff', 'ty',
      'rust_analyzer', 'gopls', 'tsgo', 'lua_ls', 'fish_lsp', 'nushell',
      'dockerls', 'terraformls',
      'smithy_ls',
      'kulala_ls', -- only useful for graphQL completion, needs the kulala_ls LSP server installed,
      'helm_ls',
    })

    if vim.g.is_work_pc then
      vim.lsp.enable('copilot')
    end

    local capabilities = require 'lsp'.client_capabilities()
    vim.lsp.config('*', { capabilities = capabilities })
  end
}
