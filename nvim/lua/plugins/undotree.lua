return {
  'mbbill/undotree',
  cmd = 'UndotreeToggle',
  keys = '<space>ou',
  config = function()
    vim.g['undotree_WindowLayout'] = 2
    vim.g['undotree_SplitWidth'] = 30
    vim.g['undotree_SetFocusWhenToggle'] = 1
  end
}
