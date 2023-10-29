return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Enables filtering See :h telescope-fzf-native.nvim-telescope-fzf-native-nvim
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
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

    local global_ignore = os.getenv('HOME') .. '/.gitignore'

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
            ["<esc>"] = actions.close,
            ["<c-[>"] = { "<esc>", type = "command" },
            ["<C-c>"] = { "<esc>", type = "command" },
            ["<C-h>"] = "which_key",
          },
          n = {
            ['<C-n>'] = actions.move_selection_next,
            ['<C-p>'] = actions.move_selection_previous,
            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,
            ['v'] = actions.select_vertical,
            ['s'] = actions.select_horizontal,
            ["r"] = function() require 'trouble.providers.telescope'.open_with_trouble() end,
            ["t"] = actions.toggle_selection,
            ["T"] = actions.toggle_all,
            ["x"] = actions.delete_buffer,
            ["q"] = actions.close,
            ["o"] = actions.send_selected_to_qflist,
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
    }

    -- 'nvim-telescope/telescope-fzf-native.nvim'
    require('telescope').load_extension('fzf')
  end
}
