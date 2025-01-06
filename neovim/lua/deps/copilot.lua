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
  }
}
