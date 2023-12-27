return {
  "simrat39/rust-tools.nvim",
  ft = 'rust',
  dependencies = {
    'neovim/nvim-lspconfig',
    'nvim-lua/plenary.nvim',
    'mfussenegger/nvim-dap',
    'akinsho/toggleterm.nvim',

  },
  config = function()
    local rt = require("rust-tools")

    HOME_PATH = os.getenv("HOME") .. "/"
    MASON_PATH = HOME_PATH .. ".local/share/nvim/mason/packages/"
    local codelldb_path = MASON_PATH .. "codelldb/extension/adapter/codelldb"
    -- change .dylib => .so if ever on linux
    local liblldb_path = MASON_PATH .. "codelldb/extension/lldb/lib/liblldb.dylib"

    rt.setup({
      tools = {
        executor = require("rust-tools.executors").toggleterm,
        hover_actions = {
          auto_focus = true,
        },
      },
      dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    })
  end
}
