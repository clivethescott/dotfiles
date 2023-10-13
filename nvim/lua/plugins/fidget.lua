return {
   {
   'j-hui/fidget.nvim',
   tag = 'legacy',
   config = function(_)
     require 'fidget'.setup {
       sources = {
         jdtls = {        -- Name of LSP client
           ignore = true, -- Ignore notifications from this source
         },
         lua_ls = {
           ignore = true, -- Ignore notifications from this source
         }
       },
     }
   end
 }
}
