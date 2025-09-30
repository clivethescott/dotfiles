return {
  'neovim/nvim-lspconfig',
  event = 'BufReadPost',
  -- event = 'VeryLazy', causes an issue where LspAttach is not called if opening files directly
  dependencies = {
    'williamboman/mason.nvim',
  },
  config = function()
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
      'rust_analyzer', 'gopls', 'ts_ls', 'lua_ls', 'fish_lsp', 'nushell',
    })

    local is_work = vim.env.IS_WORK_PC == "true"
    if is_work then
      vim.lsp.enable({ 'dockerls', 'terraformls', 'copilot',
        'smithy',
        'kulala_ls' -- only useful for graphQL completion, needs the kulala_ls LSP server installed
      })
    end

    local capabilities = require 'lsp'.client_capabilities()
    vim.lsp.config('*', { capabilities = capabilities })
  end
}
