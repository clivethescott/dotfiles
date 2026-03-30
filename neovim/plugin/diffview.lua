-- TODO: see if nvim.difftool can replace this
vim.schedule(function()
  vim.pack.add({ { src = 'https://github.com/sindrets/diffview.nvim', version = 'main' } })

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

  vim.keymap.set('n', "<space>gx", '<cmd>DiffviewClose<cr>',            { desc = "Close Diffview" })
  vim.keymap.set('n', "<space>gq", '<cmd>DiffviewClose<cr>',            { desc = "Close Diffview" })
  vim.keymap.set('n', "<space>go", '<cmd>DiffviewOpen<cr>',             { desc = "Open Diffview" })
  vim.keymap.set('n', "<space>gs", '<cmd>DiffviewOpen main...HEAD<cr>', { desc = "Diffview branch" })
end)
