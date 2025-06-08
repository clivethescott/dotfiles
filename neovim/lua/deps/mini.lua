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
        -- Number of lines within which textobject is searched
        n_lines = 200,
        silent = true,
        custom_textobjects = {
          F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
          P = ai.gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
          G = function()
            return {
              from = { line = 1, col = 1 },
              to = {
                line = vim.fn.line('$'),
                col = math.max(vim.fn.getline('$'):len(), 1)
              }
            }
          end
        },
      }
    end
  },
  {
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    opts = {
      mappings = {
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\`].', register = { cr = false } },
      }
    }
  },
}
