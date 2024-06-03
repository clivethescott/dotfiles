return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  -- branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Enables filtering See :h telescope-fzf-native.nvim-telescope-fzf-native-nvim
    { 'nvim-telescope/telescope-fzf-native.nvim',     build = 'make',     event = 'VeryLazy' },
    -- File name has highest priority
    -- { 'natecraddock/telescope-zf-native.nvim',        event = 'VeryLazy' },
    { 'nvim-telescope/telescope-live-grep-args.nvim', version = "^1.0.0", event = 'VeryLazy' },
  },
  config = function()
    local actions = require("telescope.actions")
    local open_with_trouble = require("trouble.sources.telescope").open

    local home = os.getenv('HOME')
    local global_ignore = home .. '/.gitignore'
    local open_continue = function(prompt_bufnr) -- open file and continue
      actions.select_default(prompt_bufnr)
      require("telescope.builtin").resume()
    end

    require('telescope').setup {
      defaults = {
        layout_config = {
          horizontal = {
            width = 0.9
          }
        },

        path_display = {
          -- shorten = { len = 1, exclude = { -3, -2, -1 } }
          -- truncate = {},
          filename_first = {},
          -- tail = {},
        },

        -- path_display = function(opts, path)
        --   local tail = require("telescope.utils").path_tail(path)
        --   local dir_name = vim.fn.fnamemodify(path, ":p:h")
        --   return string.format("%s--->%s", tail, dir_name)
        -- end,
        prompt_prefix = "     ",
        file_ignore_patterns = {}, -- Note that setting this may affect Telescope rendering of document symbols
        preview = {
          hide_on_startup = true,
          -- treesitter = false,
          filesize_limit = 1, -- MB
        },
        vimgrep_arguments = {
          "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case",
          "--trim", -- add this to trim indentation in results window
          "--follow"
        },
        -- https://github.com/nvim-telescope/telescope.nvim#default-mappings
        mappings = {
          i = {
            ["<c-[>"] = { "<esc>", type = "command" },
            ["<C-h>"] = "which_key",
            ["<C-i>"] = require('telescope.actions.layout').toggle_preview,
            ["<C-s>"] = actions.select_horizontal,
            -- ["<C-q>"] = actions.quickfix.., -- default
            ["<M-s>"] = actions.select_horizontal,
            ["<M-t>"] = open_with_trouble,
            ["<M-v>"] = actions.select_vertical,
          },
          n = {
            ["<M-a>"] = actions.toggle_all,
            ["<M-o>"] = open_continue,
            ["<M-d>"] = actions.delete_buffer,
            ["<M-t>"] = open_with_trouble,
            ["<C-i>"] = require('telescope.actions.layout').toggle_preview,
            ["<C-s>"] = actions.select_horizontal,
            ["<M-s>"] = actions.select_horizontal,
            ["<M-v>"] = actions.select_vertical,
            ["q"] = actions.close,
            ["<esc>"] = actions.close,
            ["?"] = "which_key",
            ["g?"] = "which_key",
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--hidden", "--max-depth", "10", "--strip-cwd-prefix", "--follow",
            "--ignore-file", global_ignore }
        },
      },
      extensions = {
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings, e.g.
          mappings = {         -- extend mappings
            i = {
              ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --type all" }),
              -- ["<C-k>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            },
          },
        }
      },
    }

    -- 'nvim-telescope/telescope-fzf-native.nvim'
    require('telescope').load_extension('fzf')
    -- require('telescope').load_extension('zf-native')
    require('telescope').load_extension('live_grep_args')
  end
}
