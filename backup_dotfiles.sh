#!/usr/bin/env sh

old_dir=$(pwd)
DOTFILES_HOME=$HOME/dotfiles
NVIM_HOME=$HOME/.config/nvim
cp $NVIM_HOME/snippets/*.snippets $DOTFILES_HOME/nvim/snippets
cp $NVIM_HOME/init2.vim $DOTFILES_HOME/nvim/init.vim
cp $NVIM_HOME/init.lua $DOTFILES_HOME/nvim/init.lua
cp $NVIM_HOME/viml/*.vim $DOTFILES_HOME/nvim/viml
cp -r $NVIM_HOME/lua $DOTFILES_HOME/nvim
cp $NVIM_HOME/coc-settings.json $DOTFILES_HOME/nvim/coc-settings.json
cp $HOME/.gitconfig $HOME/.gitignore_global $DOTFILES_HOME/git
cp $HOME/.ideavimrc $DOTFILES_HOME/ideavim/.ideavimrc
cp $HOME/.ripgreprc $DOTFILES_HOME/ripgrep/.ripgreprc
cp $HOME/.tmux.conf $DOTFILES_HOME/tmux/.tmux.conf
cp $HOME/.zsh/*.sh $DOTFILES_HOME/zsh
cp $HOME/.config/alacritty/alacritty.yml $DOTFILES_HOME/alacritty/alacritty.yml
cp $HOME/.config/ranger/rc.conf $DOTFILES_HOME/ranger/rc.conf
cp $HOME/.config/ranger/rifle.conf $DOTFILES_HOME/ranger/rifle.conf
cp $HOME/.config/ranger/commands.py $DOTFILES_HOME/ranger/commands.py
# Key remaps
cp $HOME/.Xmodmap $DOTFILES_HOME/x
# Input configuration, touchpad etc
cp /etc/X11/xorg.conf.d/99-libinput.conf $DOTFILES_HOME/x
cp $HOME/.config/i3/config $DOTFILES_HOME/i3
cp $HOME/.config/i3/i3status.conf $DOTFILES_HOME/i3
cp $HOME/ShellScripts/brightness.sh $DOTFILES_HOME/i3
cp $HOME/ShellScripts/wmclass.sh $DOTFILES_HOME/i3
cp $HOME/.config/gtk-3.0/settings.ini $DOTFILES_HOME/gtk-3/settings.init
cp $HOME/.gtkrc-2.0 $DOTFILES_HOME/gtk-2/.gtkrc-2.0
cd $DOTFILES_HOME
git add .
git commit
git push
cd $old_dir

