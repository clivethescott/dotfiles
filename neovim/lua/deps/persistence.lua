local track_repos = { 'subscription-service-v2', 'api-registry' }
return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  cond = function()
    local cwd, _, _ = vim.uv.cwd()
    return cwd and vim.tbl_contains(track_repos, vim.fn.fnamemodify(cwd, ':t'))
  end,
  opts = {
    need = 3,
    branch = true,
  },
  keys = {
    {
      '<space>ss',
      function() require("persistence").select() end,
      desc = 'Select session'
    },
    {
      '<space>so',
      function() require("persistence").load() end,
      desc = 'Load cwd session'
    },
    {
      '<space>sl',
      function() require("persistence").load({ last = true }) end,
      desc = 'Load last session'
    },
    {
      '<space>sq',
      function()
        vim.cmd('Oil ' .. vim.fs.joinpath(vim.fn.stdpath('state'), 'sessions'))
      end,
      desc = 'Open session state dir'
    },
  }
}
