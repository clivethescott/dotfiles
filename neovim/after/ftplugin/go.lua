vim.keymap.set({ 'n', 'i', 'v' }, '<c-b>', ':2TermExec cmd="go vet" direction=tab', { desc = "Go vet" })
-- https://go.dev/gopls/editor/vim#a-hrefsemantic-tokens-shadowing-idsemantic-tokens-shadowingshadowing-semantic-modifiera
vim.api.nvim_set_hl(0, '@lsp.mod.shadowing', { bold = true, underline = true })
