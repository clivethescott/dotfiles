local ok, toggleterm = pcall(require, 'toggleterm')
if not ok then
  return
end

toggleterm.setup {
  open_mapping = [[<c-\>]],
  direction = 'float',    -- 'vertical' | 'horizontal' | 'tab' | 'float',
  start_in_insert = false,
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell,  -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    -- width = <value>,
    -- height = <value>,
    -- winblend = 3,
  },
}
