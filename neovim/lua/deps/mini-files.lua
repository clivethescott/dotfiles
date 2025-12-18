local is_directory = function(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "directory"
end

return {
  'nvim-mini/mini.files',
  event = 'VeryLazy',
  config = function()
    local files = require 'mini.files'
    files.setup {
      windows = {
        preview = true,
        width_preview = 75,
      },
      options = {
        permanent_delete = true,
        use_as_default_explorer = true,
      },
      mappings = {
        go_in = '<M-l>',
        go_out = '<M-h>',
      },
    }
    vim.api.nvim_create_user_command('Files', function(args)
      local path = args.fargs and args.fargs[1] or nil
      files.open(path)
    end, { nargs = '?', complete = 'dir', desc = 'File explorer at path' })

    -- set custom marks, see :h mini-files
    local set_mark = function(id, path, desc)
      MiniFiles.set_bookmark(id, path, { desc = desc })
    end
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesExplorerOpen',
      callback = function()
        -- set_mark('c', vim.fn.stdpath('config'), 'Config') -- path
        set_mark('c', '~/.config/nvim', 'Nvim Config')
        set_mark('w', vim.fn.getcwd, 'Working directory') -- callable
        set_mark('h', '~/Code/HTTP', 'HTTP files')
        set_mark('i', '~/IdeaProjects', 'IdeaProjects')
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesWindowUpdate',
      callback = function(args)
        local win_id = args.data.win_id

        -- Customize window-local settings
        vim.wo[win_id].number = true
        vim.wo[win_id].relativenumber = true
      end,
    })

    -- Set focused directory as current working directory
    local set_cwd = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then return vim.notify('Cursor is not on valid entry') end
      vim.fn.chdir(vim.fs.dirname(path))
    end

    -- Yank in register full path of entry under cursor
    local yank_path = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then return vim.notify('Cursor is not on valid entry') end
      vim.fn.setreg(vim.v.register, path)
    end

    local grep_dir = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      local picker = vim.g.use_picker or 'fzf-lua'
      if path == nil then return vim.notify('Cursor is not on valid entry') end
      if is_directory(path) then
        if picker == 'fzf-lua' then
          require("fzf-lua").live_grep_glob { cwd = path }
          -- MiniFiles.close()
        elseif picker == 'snacks.picker' then
          MiniFiles.close()
          Snacks.picker.grep { dirs = { path } }
        end
      else
        vim.notify('Cursor is not on a directory')
      end
    end

    -- Open path with system default handler (useful for non-text files)
    local ui_open = function() vim.ui.open(MiniFiles.get_fs_entry().path) end

    local show_dotfiles = true
    local filter_show = function(fs_entry)
      return true
    end
    local filter_hide = function(fs_entry)
      local file_name = fs_entry.name
      return not (vim.startswith(file_name, ".") or vim.startswith(file_name, ".git") or vim.startswith(file_name, "target"))
    end

    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      require("mini.files").refresh({ content = { filter = new_filter } })
    end

    local map_split = function(buf_id, lhs, direction, close_on_file)
      local rhs = function()
        local new_target_window
        local cur_target_window = require("mini.files").get_explorer_state().target_window
        if cur_target_window ~= nil then
          vim.api.nvim_win_call(cur_target_window, function()
            vim.cmd("belowright " .. direction .. " split")
            new_target_window = vim.api.nvim_get_current_win()
          end)

          require("mini.files").set_target_window(new_target_window)
          require("mini.files").go_in({ close_on_file = close_on_file })
        end
      end

      local desc = "Open in " .. direction .. " split"
      if close_on_file then
        desc = desc .. " and close"
      end
      vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local bufnr = args.data.buf_id
        vim.keymap.set('n', 'g.', set_cwd, { buffer = bufnr, desc = 'Set cwd' })
        -- vim.keymap.set('n', 'gx', ui_open, { buffer = b, desc = 'OS open' })
        vim.keymap.set('n', 'gf', grep_dir, { buffer = bufnr, desc = 'Live grep dir' })
        vim.keymap.set('n', 'gy', yank_path, { buffer = bufnr, desc = 'Yank path' })
        vim.keymap.set("n", "gh", toggle_dotfiles, { buffer = bufnr, desc = "Toggle hidden files" })

        map_split(bufnr, "<C-w>s", "horizontal", false)
        map_split(bufnr, "<C-w>v", "vertical", false)
        map_split(bufnr, "<C-w>S", "horizontal", true)
        map_split(bufnr, "<C-w>V", "vertical", true)
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesActionRename",
      callback = function(event)
        require 'lsp_rename'.on_rename_file(event.data.from, event.data.to)
      end,
    })
  end,
  keys = {
    {
      '<leader>1',
      function()
        if not require 'mini.files'.close() then
          require 'mini.files'.open()
        end
      end,
      desc = 'Open Files in cwd'
    },
    { '<space>fo', function() require 'mini.files'.open() end,                             desc = 'Open Files in cwd' },
    { '<space>fO', function() require 'mini.files'.open(vim.api.nvim_buf_get_name(0)) end, desc = 'Select file in explorer' },
    { '<leader>!', function() require 'mini.files'.open(vim.api.nvim_buf_get_name(0)) end, desc = 'Select file in explorer' },
    {
      '<space>fs',
      function()
        local sessions_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "sessions")
        require 'mini.files'.open(sessions_dir)
      end,
      desc = 'Open sessions dir'
    },
  }
}
