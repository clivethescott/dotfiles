#!/usr/bin/env sh

DOTFILES_HOME=$HOME/dotfiles
cp -r $HOME/.vim/after/ftplugin $DOTFILES_HOME/vim/after/ftplugin
cp -r $HOME/.vim/vimrc $HOME/.vim/after $DOTFILES_HOME/vim
cp -r $HOME/.gitconfig $HOME/.gitignore_global $DOTFILES_HOME/git
cp -r $HOME/.config/nvim/*.vim $HOME/.config/nvim/UltiSnips $DOTFILES_HOME/nvim
cp -r $HOME/.config/nvim/coc-settings.json $DOTFILES_HOME/nvim
cp -r $HOME/.config/coc/ultisnips/*.snippets $DOTFILES_HOME/nvim/UltiSnips
cp $HOME/.ideavimrc $DOTFILES_HOME/ideavim
cp $HOME/.ripgreprc $DOTFILES_HOME/ripgrep
cp $HOME/.tmux.conf $DOTFILES_HOME/tmux
cp $HOME/.zsh/*.sh $DOTFILES_HOME/zsh
