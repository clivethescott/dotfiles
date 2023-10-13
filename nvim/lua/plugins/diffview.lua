return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  config = function()
    require 'diffview'.setup {
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        }
      }
    }
  end
}
