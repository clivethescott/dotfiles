vim.schedule(function()
  vim.pack.add({ { src = 'https://github.com/isakbm/gitgraph.nvim' } })

  require 'gitgraph'.setup {
    format = {
      timestamp = '%H:%M %-d-%b-%Y',
    },
    hooks = {
      -- Check diff of a commit
      on_select_commit = function(commit)
        vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
      end,
      -- Check diff from commit a -> commit b
      on_select_range_commit = function(from, to)
        vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
      end,
    },
    symbols = {
      merge_commit = '',
      commit = '',
      merge_commit_end = '',
      commit_end = '',

      -- Advanced symbols
      GVER = '',
      GHOR = '',
      GCLD = '',
      GCRD = '╭',
      GCLU = '',
      GCRU = '',
      GLRU = '',
      GLRD = '',
      GLUD = '',
      GRUD = '',
      GFORKU = '',
      GFORKD = '',
      GRUDCD = '',
      GRUDCU = '',
      GLUDCD = '',
      GLUDCU = '',
      GLRDCL = '',
      GLRDCR = '',
      GLRUCL = '',
      GLRUCR = '',
    },
  }
  vim.keymap.set("n", "gl", function()
    require("gitgraph").draw({}, { all = true, max_count = 5000 })
  end, { desc = "Commit graph" })

  -- Customize gitgraph colors to match default theme
  vim.api.nvim_set_hl(0, 'GitGraphHash', { fg = '#808080' })
  vim.api.nvim_set_hl(0, 'GitGraphTimestamp', { fg = '#808080' })
  vim.api.nvim_set_hl(0, 'GitGraphAuthor', { fg = '#a0a0a0' })
  vim.api.nvim_set_hl(0, 'GitGraphBranchName', { fg = '#e0e0e0', bold = true })
  vim.api.nvim_set_hl(0, 'GitGraphBranchMsg', { fg = '#d19a66' })
  vim.api.nvim_set_hl(0, 'GitGraphBranch1', { fg = '#61afef' })
  vim.api.nvim_set_hl(0, 'GitGraphBranch2', { fg = '#56b6c2' })
  vim.api.nvim_set_hl(0, 'GitGraphBranch3', { fg = '#c678dd' })
  vim.api.nvim_set_hl(0, 'GitGraphBranch4', { fg = '#98c379' })
  vim.api.nvim_set_hl(0, 'GitGraphBranch5', { fg = '#e06c75' })
end)
