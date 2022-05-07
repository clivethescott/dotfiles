local M = {}
M.setup = function()
  local ok, dap = pcall(require, 'dap')
  if not ok then
    return
  end

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

return M
