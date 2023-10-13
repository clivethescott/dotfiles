local setup_extra_adapters = function(dap)
  dap.defaults.fallback.exception_breakpoints = { 'default' }
  dap.adapters.codelldb = {
    type = 'server',
    port = 13000,
    executable = {
      command = 'codelldb',
      args = { '--port', '13000' },
    },
    name = 'lldb'
  }
end
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

  vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
  vim.fn.sign_define('DapStopped', { text = '', texthl = 'DiagnosticSignWarn', linehl = '', numhl = '' })
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
    ui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    ui.close()
  end
end


local get_program = function() return vim.fn.input('program: ', vim.loop.cwd() .. '/' .. vim.fn.expand('%f'), 'file') end
local get_args = function() return vim.split(vim.fn.input('args: ', '', 'file'), ' ') end

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

  dap.configurations.rust = {
    {
      name = 'Debug',
      type = 'codelldb',
      request = "launch",
      cwd = '${workspaceFolder}',
      terminal = 'integrated',
      console = 'integratedTerminal',
      stopOnEntry = false,
      sourceLanguages = { 'rust' },
      program = get_program,
    }
  }
end

return {
  'mfussenegger/nvim-dap',
  dependencies = {
      { "rcarriga/nvim-dap-ui" },
      { 'theHamsta/nvim-dap-virtual-text' },
      { 'leoluz/nvim-dap-go', ft = 'go', lazy = true },
    },
  config = function()

    local dap = require'dap'

    setup_extra_adapters(dap)
    setup_dap_configs(dap)
    setup_ui(dap)
    setup_dap_virt_text()
    setup_dap_go()

  end
}
