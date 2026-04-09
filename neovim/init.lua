-- Lua annotations https://github.com/LuaLS/lua-language-server/wiki/Annotations
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.use_picker = 'fzf-lua'
vim.g.is_work_pc = vim.env.IS_WORK_PC == "true"
vim.g.obsidian_work_notes_dir = '~/IdeaProjects/Obsidian/Work'
vim.g.obsidian_personal_notes_dir = '~/ObsidianNotesGit'
-- vim.g.colors_name = 'catppuccin'
vim.g.colors_name = 'default'

vim.cmd.packadd('Cfilter')       -- filter qflist
vim.cmd.packadd('nvim.difftool') -- OR :packadd nvim.difftool :Difftool -- setup for gitdiff tool -d
vim.cmd.packadd('nvim.undotree') -- :Undotree -- set :h undolist for cmds
vim.pack.add({ { src = 'https://github.com/DrKJeff16/wezterm-types' } })

require('vim._core.ui2').enable({
  enable = true,
  msg = {
    target = 'msg',
    timeout = 1000,
    msg = {           -- Options related to msg window.
      timeout = 2000, -- Time a message is visible in the message window.
    },
  },
})

local rtp_extras = vim.fs.joinpath(vim.fn.stdpath("config"), "lua/rtp")
if vim.loop.fs_stat(rtp_extras) then
  vim.opt.rtp:append(rtp_extras)
end

local on_exit = function(obj)
  vim.print('Error executing command')
  vim.print(obj.stdout)
  vim.print(obj.stderr)
end
-- must be created before first vim.pack.... call.
-- See https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack.html#hooks
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('MyPacksChanged', { clear = true }),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'blink.cmp' and kind ~= 'delete' then
      local res = vim.system({ 'cargo', 'build', '--release' }, { cwd = ev.data.path, timeout = 10000 }, on_exit):wait()
      if vim.v.shell_error ~= 0 then
        vim.notify('failed to compile blink.cmp:' .. res, vim.log.levels.ERROR)
      else
        vim.notify('blink successfully compiled', vim.log.levels.INFO)
      end
    else
      if name == 'nvim-treesitter' and kind ~= 'delete' then
        -- when changing between neovim head/stable
        -- see weird issues where new parsers don't install until old ones are removed
        if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
        vim.cmd('TSUpdate')
      end
    end
  end,
})

vim.schedule(function()
  -- Neovim has built-in support for showing diagnostic messages. This configures
  -- a more conservative display while still being useful.
  -- See `:h vim.diagnostic` and `:h vim.diagnostic.config()`.
  vim.diagnostic.config({
    float = true,
    -- jump = {
    --   float = true
    -- },
    -- Show signs on top of any other sign, but only for warnings and errors
    signs = { priority = 9999, severity = { min = 'WARN', max = 'ERROR' } },
    -- Show all diagnostics as underline
    underline = { severity = { min = 'HINT', max = 'ERROR' } },
    -- virtual_lines = true,
    -- Alternatively, customize specific options
    virtual_lines = false,
    -- virtual_lines = {
    -- Only show virtual line diagnostics for the current cursor line
    -- current_line = true,
    -- },
    virtual_text = {
      current_line = true,
      severity = { min = 'ERROR', max = 'ERROR' },
    },
    update_in_insert = false,
    severity_sort = true,
  })
end)
