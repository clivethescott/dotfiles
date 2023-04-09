require("filetype").setup({
  overrides = {
    extensions = {
      -- Set the filetype of *.pn files to potion
      hcl = "hcl",
      terraformrc = "hcl",
      tf = "terraform",
      sc = "scala",
      tfvars = "terraform",
      tfstate = "json",
      pp = "json",
      sql = "sql",
    },
    literal = {
      -- Set the filetype of files named "MyBackupFile" to lua
      MyBackupFile = "lua",
    },
  }
})
