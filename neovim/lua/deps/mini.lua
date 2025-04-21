return {
  {
    'echasnovski/mini.hipatterns',
    event = 'BufReadPost',
    opts = {
      highlighters = {
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
      },
    }
  },
  {
    'echasnovski/mini.ai',
    event = 'BufReadPost',
    config = function()
      local ai = require 'mini.ai'
      ai.setup {
        custom_textobjects = {
          F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
          P = ai.gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
        },
      }
    end
  },
  {
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    config = true,
  },
  {
    'echasnovski/mini.files',
    event = 'VeryLazy',
    config = function()
      local files = require 'mini.files'
      files.setup {
        windows = {
          preview = true,
          width_preview = 75,
        },
        options = {
          permanent_delete = false,
        }
      }
      vim.api.nvim_create_user_command('Files', function(args)
        local path = args.fargs and args.fargs[1] or nil
        files.open(path)
      end, { nargs = '?', complete = 'dir', desc = 'File explorer at path' })
    end,
    keys = {
      { '<leader>1', function() require 'mini.files'.open() end,                             desc = 'Open Files in cwd' },
      { '<space>fo', function() require 'mini.files'.open() end,                             desc = 'Open Files in cwd' },
      { '<space>fO', function() require 'mini.files'.open(vim.api.nvim_buf_get_name(0)) end, desc = 'Select file in explorer' },
    }
  }
}
