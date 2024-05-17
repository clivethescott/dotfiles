return {
  "mrcjkb/rustaceanvim",
  version = '^4', -- Recommended
  ft = { 'rust' },
  cond = function()
    return require 'helper.utils'.plugin_conf().rust_enabled
  end,
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
        reload_workspace_from_cargo_toml = true,
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
