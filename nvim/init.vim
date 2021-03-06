source $HOME/.config/nvim/viml/nvim-options.vim
source $HOME/.config/nvim/viml/abbreviations.vim
source $HOME/.config/nvim/viml/vim-plug.vim
source $HOME/.config/nvim/viml/colorscheme.vim
source $HOME/.config/nvim/viml/nvim-keymap.vim

" Plugin Configuration
source $HOME/.config/nvim/viml/startify.vim
source $HOME/.config/nvim/viml/vimgo.vim
source $HOME/.config/nvim/viml/lightline.vim
source $HOME/.config/nvim/viml/gitgutter.vim
source $HOME/.config/nvim/viml/fugitive.vim
source $HOME/.config/nvim/viml/undotree.vim
" source $HOME/.config/nvim/viml/fern.vim
source $HOME/.config/nvim/viml/coc.vim
source $HOME/.config/nvim/viml/startify.vim
source $HOME/.config/nvim/viml/autogroups.vim
source $HOME/.config/nvim/viml/rnvimr.vim

lua <<EOF
-- require('lsp-config')
-- require('nvim-compe')
-- require('dart-lsp')
require('plugins.treesitter-config')
require('plugins.telescope-config')
EOF

