return {
  "simrat39/rust-tools.nvim",
  ft = 'rust',
  cond = false, -- GH repo has been archived
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

    local is_mac = vim.loop.os_uname().sysname == 'Darwin'
    local lib_ext = '.so'
    if is_mac then
      lib_ext = '.dylib'
    end
    local liblldb_path = MASON_PATH .. "codelldb/extension/lldb/lib/liblldb" .. lib_ext

    rt.setup({
      tools = {
        executor = require("rust-tools.executors").toggleterm,
        hover_actions = {
          auto_focus = true,
        },
        inlay_hints = {
          auto = false -- set by lvimuser/lsp-inlayhints.nvim
        },
      },
      dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    })
  end
}
