-- Lua annotations https://github.com/LuaLS/lua-language-server/wiki/Annotations
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.use_picker = 'fzf-lua'
vim.g.is_work_pc = vim.env.IS_WORK_PC == "true"
vim.g.obsidian_work_notes_dir = '~/IdeaProjects/Obsidian/Work'
vim.g.obsidian_personal_notes_dir = '~/ObsidianNotesGit'
-- vim.g.colors_name = 'catppuccin'
vim.g.colors_name = 'default'
vim.cmd.packadd 'cfilter'

-- vim.cmd.packadd('Cfilter') -- filter qflist
-- vim.cmd.packadd('nvim.difftool') OR :packadd nvim.difftool :Difftool -- setup for gitdiff tool -d
-- vim.cmd.packadd('nvim.undotree') :Undotree -- set :h undolist for cmds

-- require('vim._core.ui2').enable({ https://github.com/neovim/neovim/issues/37929
--   enable = true, msg = { target = 'msg', timeout = 1000 },
-- })

local rtp_extras = vim.fs.joinpath(vim.fn.stdpath("config"), "lua/rtp")
if vim.loop.fs_stat(rtp_extras) then
  vim.opt.rtp:append(rtp_extras)
end

-- must be created before first vim.pack.... call.
-- See https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack.html#hooks
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('MyPacksChanged', { clear = true }),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'blink.cmp' and kind ~= 'delete' then
      --TODO: check why this has issues sometimes
      local res = vim.system({ 'cargo build --release' }, { cwd = ev.data.path }):wait(10000) -- in millis
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
