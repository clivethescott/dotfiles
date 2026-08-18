local say_handle = nil

local function speak(text)
  if not text or text == '' then return end
  local handle
  handle = vim.system({ 'say' }, { stdin = text }, function()
    if say_handle == handle then say_handle = nil end
  end)
  say_handle = handle
end

local function toggle(text)
  if say_handle then
    say_handle:kill(15) -- SIGTERM: stop current speech
    say_handle = nil
    return
  end
  speak(text)
end

vim.keymap.set('n', '<leader>S', function()
  toggle(table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n'))
end, { desc = 'Say: toggle speak whole buffer' })

vim.keymap.set('x', '<leader>S', function()
  local text = table.concat(
    vim.fn.getregion(vim.fn.getpos('v'), vim.fn.getpos('.'), { type = vim.fn.mode() }),
    '\n')
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
  toggle(text)
end, { desc = 'Say: toggle speak selection' })
