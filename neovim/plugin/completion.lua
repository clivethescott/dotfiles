vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect', 'fuzzy', 'popup' }
vim.o.pumborder = 'rounded'
vim.o.pummaxwidth = 60

local blink_enabled = vim.g.blink_enabled or true
if blink_enabled then return end

vim.o.autocomplete = true

-- Native Neovim 0.12 completion options and keymaps
-- Replaces blink.cmp configuration

-- Confirm selected completion item with <cr>, or insert newline if menu not visible
vim.keymap.set('i', '<cr>', function()
  return vim.fn.pumvisible() == 1 and '<C-y>' or '<cr>'
end, { expr = true, desc = 'Confirm completion or newline' })

-- Snippet navigation (replaces blink snippet_forward / snippet_backward)
vim.keymap.set({ 'i', 's' }, '<c-j>', function()
  if vim.snippet.active({ direction = 1 }) then vim.snippet.jump(1) end
end, { desc = 'Snippet: jump forward' })

vim.keymap.set({ 'i', 's' }, '<c-k>', function()
  if vim.snippet.active({ direction = -1 }) then vim.snippet.jump(-1) end
end, { desc = 'Snippet: jump back' })

