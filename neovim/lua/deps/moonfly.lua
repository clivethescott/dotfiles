return {
  "bluz71/vim-moonfly-colors",
  name = "moonfly",
  lazy = true,
  cond = false,
  -- priority = 1000,
  init = function()
    vim.g.moonflyUndercurls = true
    vim.g.moonflyUnderlineMatchParen = true
  end
}
