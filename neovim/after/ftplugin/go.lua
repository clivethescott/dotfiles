vim.keymap.set({ 'n', 'i', 'v' }, '<c-b>', ':2TermExec cmd="go vet" direction=tab', { desc = "Go vet" })
