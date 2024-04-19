return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Enables filtering See :h telescope-fzf-native.nvim-telescope-fzf-native-nvim
    { 'nvim-telescope/telescope-fzf-native.nvim',     build = 'make',     event = 'VeryLazy' },
    { 'nvim-telescope/telescope-live-grep-args.nvim', version = "^1.0.0", event = 'VeryLazy' },
  },
  config = function()
    local actions = require("telescope.actions")
    local previewers = require("telescope.previewers")
    local Job = require("plenary.job")

    -- don't preview binaries
    local new_maker = function(filepath, bufnr, opts)
      filepath = vim.fn.expand(filepath)
      Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
          local og_mime_type = j:result()[1]
          local mime_type = vim.split(og_mime_type, "/", { plain = true, trimempty = true })[1]
          if mime_type == "text" or string.find(og_mime_type, 'json') then
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
          else
            -- maybe we want to write something to the buffer here
            vim.schedule(function()
              vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
            end)
          end
        end
      }):sync()
    end

    local home = os.getenv('HOME')
    local global_ignore = home .. '/.gitignore'

    require('telescope').setup {
      defaults = {
        layout_config = {
          horizontal = {
            width = 0.9
          }
        },

        path_display = {
          -- shorten = { len = 1, exclude = { -3, -2, -1 } }
          truncate = {},
          -- tail = {},
        },

        -- path_display = function(opts, path)
        --   local tail = require("telescope.utils").path_tail(path)
        --   local dir_name = vim.fn.fnamemodify(path, ":p:h")
        --   return string.format("%s--->%s", tail, dir_name)
        -- end,
        prompt_prefix = "     ",
        file_ignore_patterns = {}, -- Note that setting this may affect Telescope rendering of document symbols
        buffer_previewer_maker = new_maker,
        preview = {
          hide_on_startup = true,
          treesitter = false,
          filesize_limit = 5, -- MB
        },
        vimgrep_arguments = {
          "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case",
          "--trim", -- add this to trim indentation in results window
          "--follow"
        },
        mappings = {
          i = {
            ['<C-n>'] = actions.move_selection_next,
            ['<C-p>'] = actions.move_selection_previous,
            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            -- ["<esc>"] = actions.close,
            ["<c-[>"] = { "<esc>", type = "command" },
            ["<C-c>"] = actions.close,
            ["<C-h>"] = "which_key",
            ["<C-i>"] = require('telescope.actions.layout').toggle_preview,
            ["<C-o>"] = function(prompt_bufnr) -- open file and continue
              actions.select_default(prompt_bufnr)
              require("telescope.builtin").resume()
            end,
            ["<C-q>"] = actions.close,
            ["<C-y>"] = function(prompt_bufnr)
              actions.send_to_qflist(prompt_bufnr)
              vim.cmd('copen')
            end,
            ["<C-g>"] = actions.send_selected_to_qflist,
            ["<C-t>"] = actions.toggle_selection,
            ["<C-s>"] = actions.select_vertical,
          },
          n = {
            ['<C-n>'] = actions.move_selection_next,
            ['<C-p>'] = actions.move_selection_previous,
            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,
            ["<C-q>"] = actions.close,
            ['gv'] = actions.select_vertical,
            ['gs'] = actions.select_horizontal,
            ["go"] = function() require 'trouble.providers.telescope'.open_with_trouble() end,
            ["gt"] = actions.toggle_selection,
            ["gT"] = actions.toggle_all,
            ["gx"] = actions.delete_buffer,
            ["q"] = actions.close,
            ["gq"] = actions.send_selected_to_qflist,
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
          -- ... also accepts theme settings, for example:
          -- theme = "dropdown", -- use dropdown theme
          -- theme = { }, -- use own theme spec
          -- layout_config = { mirror=true }, -- mirror preview pane
        }
      },
    }

    -- 'nvim-telescope/telescope-fzf-native.nvim'
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('live_grep_args')
  end
}
