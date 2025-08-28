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
      },
      mappings = {
        go_in = '<M-l>',
        go_out = '<M-h>'
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

    -- Open path with system default handler (useful for non-text files)
    local ui_open = function() vim.ui.open(MiniFiles.get_fs_entry().path) end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local b = args.data.buf_id
        vim.keymap.set('n', 'g.', set_cwd, { buffer = b, desc = 'Set cwd' })
        vim.keymap.set('n', 'gx', ui_open, { buffer = b, desc = 'OS open' })
        vim.keymap.set('n', 'gy', yank_path, { buffer = b, desc = 'Yank path' })
      end,
    })
  end,
  keys = {
    { '<leader>1', function() require 'mini.files'.open() end,                             desc = 'Open Files in cwd' },
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
