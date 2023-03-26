#!/usr/bin/env sh

DOTFILES_HOME=$HOME/dotfiles
NVIM_HOME=$HOME/.config/nvim

cp $DOTFILES_HOME/nvim/init.lua $NVIM_HOME/init.lua 
cp -r $DOTFILES_HOME/nvim/lua/* $NVIM_HOME/lua 

