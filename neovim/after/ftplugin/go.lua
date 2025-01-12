vim.keymap.set({ 'n', 'i', 'v' }, '<c-b>',
  function()
    require 'snacks'.terminal.open('go vet', { interactive = false })
  end,
  { desc = "Go vet" })
