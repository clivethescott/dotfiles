return {
  "rmagatti/auto-session",
  dependencies = {
    'nvim-telescope/telescope.nvim'
  },
  config = function()
    require "auto-session".setup {
      auto_restore_enabled        = false,
      log_level                   = 'error',
      auto_save_enabled           = true,
      auto_session_allowed_dirs   = { "~/Code", "~/IdeaProjects" },
      auto_session_use_git_branch = true,
    }
    require("telescope").load_extension("session-lens")
  end
}
