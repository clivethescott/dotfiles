return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Enables filtering See :h telescope-fzf-native.nvim-telescope-fzf-native-nvim
    { 'nvim-telescope/telescope-fzf-native.nvim',     build = 'make',     event = 'VeryLazy' },
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
        prompt_prefix = "     ",
        file_ignore_patterns = {}, -- Note that setting this may affect Telescope rendering of document symbols
        preview = {
          hide_on_startup = true,
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
            ["<C-i>"] = require('telescope.actions.layout').toggle_preview,
          },
          n = {
            ["<M-a>"] = actions.toggle_all,
            ["<M-o>"] = open_continue,
            ["<M-d>"] = actions.delete_buffer,
            ["<M-t>"] = open_with_trouble,
            ["<C-i>"] = require('telescope.actions.layout').toggle_preview,
            ["<M-s>"] = actions.select_horizontal,
            ["<M-v>"] = actions.select_vertical,
            ["q"] = actions.close,
            ["<esc>"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--hidden", "--max-depth", "10", "--strip-cwd-prefix", "--follow",
            "--ignore-file", global_ignore },
        },
      },
      extensions = {
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          mappings = {         -- extend mappings
            i = {
              ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --type all" }),
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
