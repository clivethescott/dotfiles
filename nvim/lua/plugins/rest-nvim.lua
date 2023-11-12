return {
  "rest-nvim/rest.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = 'http',
  config = function()
    require("rest-nvim").setup({
      result_split_in_place = true, -- open vsplits to the right
      result = {
        show_url = false,
        show_http_info = false,
        show_headers = false,
        show_curl_command = false,
      },
      custom_dynamic_variables = {
        ["$now"] = function()
          return os.date('%Y-%m-%dT%T.000Z')
        end
      },
    })
  end
}
