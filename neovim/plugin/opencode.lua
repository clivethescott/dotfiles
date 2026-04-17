vim.schedule(function()
  ---@type opencode.Opts|nil
  local config = {
    server = {
      start = function()
        -- https://github.com/nickjvandyke/opencode.nvim/blob/main/lua/opencode/config.lua
        require("opencode.terminal").open("opencode --port", {
          split = "right",
          width = math.floor(vim.o.columns * 0.5),
        })
      end,
      toggle = function()
        require("opencode.terminal").toggle("opencode --port", {
          split = "right",
          width = math.floor(vim.o.columns * 0.5),
        })
      end,
    },
    lsp = {
      enabled = true
    }
  }
  vim.g.opencode_opts = config
  vim.pack.add({ { src = 'https://github.com/nickjvandyke/opencode.nvim' } })


  vim.keymap.set({ "n", "x" }, "<space>at", function() require("opencode").ask("@this: ", { submit = true }) end,
    { desc = "Ask opencode…" })
  vim.keymap.set({ "n", "x" }, "<space>as", function() require("opencode").select() end,
    { desc = "Execute opencode action…" })
  vim.keymap.set({ "n", "t" }, "<space>ao", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

  vim.keymap.set({ "x" }, "<space>ar", function() return require("opencode").operator("@this ") end,
    { desc = "Add range to opencode", expr = true })
  vim.keymap.set("n", "<space>al", function() return require("opencode").operator("@this ") .. "_" end,
    { desc = "Add line to opencode", expr = true })
end)
