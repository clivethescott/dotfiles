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

    local os_info = vim.fn.system('uname -a')
    local is_mac = string.find(os_info, 'Darwin')
    HOME_PATH = os.getenv("HOME") .. "/"
    MASON_PATH = HOME_PATH .. ".local/share/nvim/mason/packages/"
    local codelldb_path = MASON_PATH .. "codelldb/extension/adapter/codelldb"
    local liblldb_path = MASON_PATH .. "codelldb/extension/lldb/lib/liblldb"

    if is_mac then
      liblldb_path = liblldb_path .. '.dylib'
    else
      liblldb_path = liblldb_path .. '.so'
    end

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
