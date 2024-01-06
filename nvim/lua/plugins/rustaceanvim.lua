return {
  "mrcjkb/rustaceanvim",
  version = '^3', -- Recommended
  ft = { 'rust' },
  init = function()
    local cfg = require('rustaceanvim.config')

    -- Configure rustaceanvim here
    HOME_PATH = os.getenv("HOME") .. "/"
    MASON_PATH = HOME_PATH .. ".local/share/nvim/mason/packages/"
    local codelldb_path = MASON_PATH .. "codelldb/extension/adapter/codelldb"

    local is_mac = vim.loop.os_uname().sysname == 'Darwin'
    local lib_ext = '.so'
    if is_mac then
      lib_ext = '.dylib'
    end
    local liblldb_path = MASON_PATH .. "codelldb/extension/lldb/lib/liblldb" .. lib_ext

    vim.g.rustaceanvim = {
      tools = {
        executor = require("rustaceanvim.executors").toggleterm,
        hover_actions = {
          auto_focus = false,
        },
      },
      dap = {
        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    }
  end,
}
