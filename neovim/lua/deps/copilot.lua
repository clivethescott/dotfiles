return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
  },
  dependencies = {
    "giuxtaposition/blink-cmp-copilot"
  },
  filetypes = {
    ["grug-far"] = false,
    ["grug-far-history"] = false,
    ["grug-far-help"] = false,
    ["fish"] = false,
    ["zsh"] = false,
    ["lua"] = false,
  }
}
