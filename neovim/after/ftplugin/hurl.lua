-- !freeze when using vim-tmux-navigator
local modes = {'n', 'i', 'v'}
local notify_disabled = function()
  vim.notify_once('Disabled to avoid freezing', vim.log.levels.WARN)
end
for _, mode in ipairs(modes) do
  vim.keymap.set(mode, '<M-h>', notify_disabled, {buffer = true})
  vim.keymap.set(mode, '<M-j>', notify_disabled, {buffer = true})
  vim.keymap.set(mode, '<M-k>', notify_disabled, {buffer = true})
  vim.keymap.set(mode, '<M-l>', notify_disabled, {buffer = true})
end
