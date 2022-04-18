source $HOME/.config/nvim/settings/nvim-options.vim
source $HOME/.config/nvim/settings/abbreviations.vim
source $HOME/.config/nvim/settings/vim-plug.vim
source $HOME/.config/nvim/settings/colorscheme.vim
source $HOME/.config/nvim/settings/nvim-keymap.vim

" Plugin Configuration
source $HOME/.config/nvim/settings/startify.vim
source $HOME/.config/nvim/settings/vimgo.vim
source $HOME/.config/nvim/settings/lightline.vim
source $HOME/.config/nvim/settings/gitgutter.vim
source $HOME/.config/nvim/settings/fugitive.vim
source $HOME/.config/nvim/settings/undotree.vim
source $HOME/.config/nvim/settings/coc.vim
source $HOME/.config/nvim/settings/startify.vim
source $HOME/.config/nvim/settings/autogroups.vim
source $HOME/.config/nvim/settings/fern.vim
source $HOME/.config/nvim/settings/fzf.vim
source $HOME/.config/nvim/settings/fzfcheckout.vim
source $HOME/.config/nvim/settings/snippets.vim
" source $HOME/.config/nvim/settings/rnvimr.vim

lua <<EOF
-- require('lsp-config')
-- require('nvim-compe')
-- require('dart-lsp')
require('treesitter-config')
-- require('plugins.telescope-config')
EOF

