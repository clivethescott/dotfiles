vim.keymap.set({ 'n', 'i', 'v' }, '<c-b>',
  ':2TermExec cmd="dune build" direction=tab<cr> display_name="Dune Build" close_on_exit=true ', { desc = "Build" })
