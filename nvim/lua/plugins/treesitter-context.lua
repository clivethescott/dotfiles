return {
  'romgrk/nvim-treesitter-context',
  ft = {'python', 'yaml', 'json'},
  config = function()
    require 'treesitter-context'.setup {}
  end
}
