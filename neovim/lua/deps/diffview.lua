return {
  'diffview.nvim',
  event = 'DeferredUIEnter',
  keys = {
    { "<space>gx", '<cmd>DiffviewClose<cr>',            desc = "Close Diffview" },
    { "<space>gq", '<cmd>DiffviewClose<cr>',            desc = "Close Diffview" },
    { "<space>go", '<cmd>DiffviewOpen<cr>',             desc = "Open Diffview" },
    { "<space>gs", '<cmd>DiffviewOpen main...HEAD<cr>', desc = "Diffview branch" },
  },
  after = function()
    require('diffview').setup({
      default_args = {
        DiffviewOpen = { "--imply-local" }, -- https://github.com/sindrets/diffview.nvim/blob/main/USAGE.md#comparing-all-the-changes
      },
      view = {
        -- Configure the layout and behavior of different types of views.
        -- Available layouts:
        --  'diff1_plain'
        --    |'diff2_horizontal'
        --    |'diff2_vertical'
        --    |'diff3_horizontal'
        --    |'diff3_vertical'
        --    |'diff3_mixed'
        --    |'diff4_mixed'
        -- For more info, see |diffview-config-view.x.layout|.
        default = {
          -- Config for changed files, and staged files in diff views.
          layout = 'diff2_horizontal',
          disable_diagnostics = false, -- Temporarily disable diagnostics for diff buffers while in the view.
          winbar_info = false,         -- See |diffview-config-view.x.winbar_info|
        },
        merge_tool = {
          -- Config for conflicted files in diff views during a merge or rebase.
          layout = "diff3_horizontal",
          disable_diagnostics = true, -- Temporarily disable diagnostics for diff buffers while in the view.
          winbar_info = true,         -- See |diffview-config-view.x.winbar_info|
        },
      },
    })
  end,
}
