-- https://github.com/obsidian-nvim/obsidian.nvim/blob/47bd91e3edb95649f4347b2fef929446112fff21/lua/obsidian/config/init.lua#L36
local obsidian_pickers = {
  telescope = "telescope.nvim",
  ['fzf-lua'] = "fzf-lua",
  mini = "mini.pick",
  ['snacks.picker'] = "snacks.pick",
}
local picker = vim.g.use_picker or 'fzf-lua'
local obsidian_picker = obsidian_pickers[picker] or picker

local workspaces = {
  {
    name = "Work Notes",
    path = vim.g.obsidian_work_notes_dir,
  },
  {
    name = "Personal Notes",
    path = vim.g.obsidian_personal_notes_dir,
  },
}

-- Sort workspaces: Notes first when at home, Work first when at work PC
if not vim.g.is_work_pc then
  workspaces[1], workspaces[2] = workspaces[2], workspaces[1]
end

---@diagnostic disable: missing-fields
return {
  'obsidian.nvim',
  event = 'DeferredUIEnter',
  after = function()
    ---@module 'obsidian'
    ---@type obsidian.config
    require('obsidian').setup({
      workspaces = workspaces,
      legacy_commands = false,
      log_level = vim.log.levels.WARN,
      completion = { blink = true, min_chars = 2 },
      open = {
        func = function(uri)
          vim.ui.open(uri, { cmd = { "open", "-a", "/Applications/Obsidian.app" } })
        end
      },
      picker = {
        name = obsidian_picker,
      },
      ui = { enable = false }, -- use MeanderingProgrammer/render-markdown.nvim
      daily_notes = {
        folder = 'daily'
      },
    })
  end,
  keys = {
    {
      '<space>no',
      '<cmd>Obsidian quick_switch<cr>',
      desc = 'Open/Switch Note'
    },
    {
      '<space>nf',
      '<cmd>Obsidian search<cr>',
      desc = 'Grep Search Note'
    },
    {
      '<space>nO',
      '<cmd>Obsidian open<cr>',
      desc = 'Open Note in Obsidian app'
    },
    {
      '<space>nn',
      '<cmd>Obsidian today<cr>',
      desc = "Open Today's Note"
    },
    {
      '<space>nt',
      '<cmd>Obsidian tags<cr>',
      desc = "Notes by Tag"
    },
    {
      '<space>nw',
      '<cmd>Obsidian workspace<cr>',
      desc = "Switch workspace"
    }
  }
}
