return {
  "rcarriga/nvim-dap-ui",
  keys = {'<space>d'},
  dependencies = { 'mfussenegger/nvim-dap' },
  config = function()
    local ui = require 'dapui'
    local dap = require 'dap'
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
      vim.notify('Debug Session Ended', vim.log.levels.INFO)
    end
  end
}
