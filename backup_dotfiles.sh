#!/usr/bin/env sh

old_dir=$(pwd)
DOTFILES_HOME=$HOME/dotfiles
NVIM_HOME=$HOME/.config/nvim
cp $NVIM_HOME/init.lua $DOTFILES_HOME/nvim/init.lua
rm -rf $DOTFILES_HOME/nvim/lua && cp -r $NVIM_HOME/lua $DOTFILES_HOME/nvim
cp -r $NVIM_HOME/luasnippets $DOTFILES_HOME/nvim
cp $HOME/.gitconfig $HOME/.gitignore $DOTFILES_HOME/git
cp $HOME/.ideavimrc $DOTFILES_HOME/ideavim/.ideavimrc
cp $HOME/.ripgreprc $DOTFILES_HOME/ripgrep/.ripgreprc
cp $HOME/.tmux.conf $DOTFILES_HOME/tmux/.tmux.conf
cp $HOME/.zsh/*.sh $DOTFILES_HOME/zsh
cp $HOME/.zshrc $DOTFILES_HOME/zsh
cp $HOME/.zprofile $DOTFILES_HOME/zsh
# Input configuration, touchpad etc
cp $HOME/.sbt/1.0/build.sbt $DOTFILES_HOME/sbt

cd $DOTFILES_HOME
lazygit

