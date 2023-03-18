local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local Job = require("plenary.job")

-- Use terminal image viewer to preview images
local mime_hook = function(filepath, bufnr, opts)
  local is_image = function(fpath)
    local image_extensions = { 'png', 'jpg' } -- Supported image formats
    local split_path = vim.split(fpath:lower(), '.', { plain = true })
    local extension = split_path[#split_path]
    return vim.tbl_contains(image_extensions, extension)
  end
  if is_image(filepath) then
    local term = vim.api.nvim_open_term(bufnr, {})
    local function send_output(_, data, _)
      for _, d in ipairs(data) do
        vim.api.nvim_chan_send(term, d .. '\r\n')
      end
    end

    vim.fn.jobstart(
      {
        'catimg', filepath -- Terminal image viewer command
      },
      { on_stdout = send_output, stdout_buffered = true })
  else
    require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
  end
end

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

local trouble = require("trouble.providers.telescope")
local global_ignore = os.getenv('HOME') .. '/.gitignore'
local fb_actions = require "telescope".extensions.file_browser.actions

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
    prompt_prefix = "     ",
    file_ignore_patterns = {}, -- Note that setting this may affect Telescope rendering of document symbols
    buffer_previewer_maker = new_maker,
    preview = {
      mime_hook = mime_hook,
      treesitter = false,
    },
    vimgrep_arguments = {
      "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case",
      "--trim" -- add this to trim indentation in results window
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
        ["<C-c>"] = { "<esc>", type = "command" },
        -- open search results with trouble
        ["<c-t>"] = trouble.open_with_trouble,
        ["<c-x>"] = actions.delete_buffer,
        -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-h>"] = "which_key",
      },
      n = {
        ["<c-t>"] = trouble.open_with_trouble,
        ["<C-h>"] = fb_actions.goto_home_dir,
        ["<esc>"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<c-x>"] = actions.delete_buffer,
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
    file_browser = {
      -- path
      -- cwd
      cwd_to_path = false,
      grouped = true,
      files = true,
      add_dirs = true,
      depth = 1,
      auto_depth = false,
      select_buffer = false,
      hidden = false,
      -- respect_gitignore
      -- browse_files
      -- browse_folders
      hide_parent_dir = false,
      collapse_dirs = false,
      quiet = false,
      dir_icon = "",
      dir_icon_hl = "Default",
      display_stat = { date = true, size = true },
      hijack_netrw = false,
      use_fd = true,
      git_status = true,
      mappings = {
        ["i"] = {
          ["<A-c>"] = false,
          ["<S-CR>"] = false,
          ["<A-r>"] = false,
          ["<A-m>"] = false,
          ["<A-y>"] = false,
          ["<A-d>"] = false,
          ["<C-o>"] = fb_actions.open, -- Open with system default application
          ["<C-g>"] = fb_actions.goto_parent_dir,
          ["<C-a>"] = fb_actions.goto_home_dir,
          ["<C-w>"] = fb_actions.goto_cwd,
          ["<C-t>"] = fb_actions.change_cwd,
          ["<C-f>"] = fb_actions.toggle_browser,
          ["<C-h>"] = fb_actions.toggle_hidden,
          ["<C-s>"] = fb_actions.toggle_all,
        },
        ["n"] = {
          ["a"] = fb_actions.create,
          ["r"] = fb_actions.rename,
          ["x"] = fb_actions.move,
          ["y"] = fb_actions.copy,
          ["d"] = fb_actions.remove,
          ["o"] = fb_actions.open,
          ["gp"] = fb_actions.goto_parent_dir,
          ["gh"] = fb_actions.goto_home_dir,
          ["gc"] = fb_actions.goto_cwd,
          ["gg"] = fb_actions.change_cwd,
          ["f"] = fb_actions.toggle_browser,
          ["g."] = fb_actions.toggle_hidden,
          ["s"] = fb_actions.toggle_all,
        },
      },
    },
  },
}

-- Enable telescope fzf native
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require("telescope").load_extension "file_browser"

-- requires nvim-telescope/telescope-dap.nvim
require('telescope').load_extension('dap')
