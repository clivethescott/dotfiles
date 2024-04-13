local setup_extra_adapters = function(dap)
  dap.defaults.fallback.exception_breakpoints = { 'default' }
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      -- command = vim.fn.exepath('codelldb'),
      command = 'codelldb',
      args = { "--port", "${port}" },
      detached = false,
    }
  }
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

  dap.configurations.rust = {
    {
      type = "codelldb",
      request = "launch",
      name = "Launch File",
      program = function()
        return vim.fn.input({
          prompt = 'Path to executable: ',
          default = vim.fn.getcwd() .. '/',
          completion = 'file',
        })
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      showDisassembly = "never",
    },
  }
end

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    { 'theHamsta/nvim-dap-virtual-text',  opts = {} },
    { 'leoluz/nvim-dap-go',               opts = {}, ft = 'go' },
    { 'nvim-telescope/telescope.nvim' },
    { 'nvim-telescope/telescope-dap.nvim' },
    "rcarriga/nvim-dap-ui",
  },
  cond = function()
    return false -- require 'helper.utils'.is_home_setup()
  end,
  config = function()
    local dap = require 'dap'

    require('telescope').load_extension('dap')

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DiagnosticSignWarn', linehl = '', numhl = '' })

    setup_extra_adapters(dap)
    setup_dap_configs(dap)
  end
}
