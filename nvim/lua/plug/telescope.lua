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
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
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

require('telescope').setup {
  defaults = {
    file_ignore_patterns = { "target", "node_modules", ".metals", ".git", ".idea", ".jar", "venv", ".bloop", ".bsp",
      "undodir", ".DS_Store" },
    buffer_previewer_maker = new_maker,
    preview = {
      mime_hook = mime_hook,
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
        ["<C-h>"] = "which_key",
        ["<esc>"] = actions.close,
        ["<C-c>"] = actions.close,
        -- open search results with trouble
        ["<c-t>"] = trouble.open_with_trouble,
        ["<c-x>"] = actions.delete_buffer,
        -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
      n = {
        ["<c-t>"] = trouble.open_with_trouble,
        ["<esc>"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<c-x>"] = actions.delete_buffer,
        ["?"] = "which_key",
      },
    },
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--hidden", "--max-depth", "10", "--strip-cwd-prefix" }
    },
  },
}

-- Enable telescope fzf native
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
