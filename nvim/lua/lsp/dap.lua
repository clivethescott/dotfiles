local setup_dap_go = function()
  local ok, dap_go = pcall(require, 'dap-go')
  if not ok then
    return
  end
  dap_go.setup()
end

local setup_dap_virt_text = function()
  local ok, dap_virt_text = pcall(require, 'nvim-dap-virtual-text')
  if not ok then
    return
  end

  dap_virt_text.setup()

  vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointRejected', { text = '🟦', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapStopped', { text = '⭐️', texthl = '', linehl = '', numhl = '' })
end

local setup_ui = function(dap)
  local ok, ui = pcall(require, 'dapui')
  if not ok then
    return
  end

  ui.setup({
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
  })

  -- You can use nvim-dap events to open and close the windows automatically
  dap.listeners.after.event_initialized["dapui_config"] = function()
    vim.notify('Debug Session Started', vim.log.levels.INFO)
    ui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    vim.notify('Debug Session Terminated', vim.log.levels.INFO)
    ui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    vim.notify('Debug Session Exited', vim.log.levels.WARN)
    ui.close()
  end
end

local setup_dap_configs = function(dap)

  dap.configurations.scala = {
    {
      type = "scala",
      request = "launch",
      name = "Run or Test File",
      metals = {
        runType = "runOrTestFile",
      },
    },
    {
      type = "scala",
      request = "launch",
      name = "Test Build Target",
      metals = {
        runType = "testTarget",
      },
    },
  }
end

local M = {}

M.setup = function()
  local ok, dap = pcall(require, 'dap')
  if not ok then
    return
  end

  setup_dap_configs(dap)
  setup_ui(dap)
  setup_dap_virt_text()
  setup_dap_go()
end

return M
