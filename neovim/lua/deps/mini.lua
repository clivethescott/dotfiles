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
          f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
          g = function()
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
