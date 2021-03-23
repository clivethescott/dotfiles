#!/usr/bin/env sh

old_dir=$(pwd)
DOTFILES_HOME=$HOME/dotfiles
cp $HOME/.config/nvim/snippets/*.snippets $DOTFILES_HOME/nvim/snippets
cp $HOME/.gitconfig $HOME/.gitignore_global $DOTFILES_HOME/git
cp $HOME/.config/nvim/init.vim $DOTFILES_HOME/nvim
cp $HOME/.config/nvim/viml/*.vim $DOTFILES_HOME/nvim/viml
cp $HOME/.config/nvim/lua/*.lua $DOTFILES_HOME/nvim/lua
cp $HOME/.config/nvim/coc-settings.json $DOTFILES_HOME/nvim
cp $HOME/.ideavimrc $DOTFILES_HOME/ideavim
cp $HOME/.ripgreprc $DOTFILES_HOME/ripgrep
cp $HOME/.tmux.conf $DOTFILES_HOME/tmux
cp $HOME/.zsh/*.sh $DOTFILES_HOME/zsh
cp $HOME/.config/alacritty/* $DOTFILES_HOME/alacritty
cd $DOTFILES_HOME
git add .
git commit
git push
cd $old_dir

