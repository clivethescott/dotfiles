export BROWSER=/usr/bin/firefox
export MEDIA=/media/clive/Data
export MYVIMRC=$HOME/.vim/vimrc
export APP_HOME=$HOME/apps
export ANDROID_SDK_HOME=$HOME/Android/Sdk
export ANDROID_PREFS_ROOT=$ANDROID_SDK_HOME
export ANDROID_HOME=$ANDROID_SDK_HOME
export YARN_HOME=/usr/share/yarn
export VISUALVM_HOME=$APP_HOME/visualvm
export IDEA_HOME=$APP_HOME/intellij
export NODE_HOME=$APP_HOME/node
export GO_HOME=$APP_HOME/go
export CARGO_HOME=$HOME/.cargo
export EDITOR=nvim
export VISUAL=$EDITOR
export HOSTALIASES=$HOME/.hosts
export GOPATH=$HOME/GoProjects
export GOBIN=$GOPATH/bin
export PROTOBUF_HOME=$APP_HOME/protobuf-compiler
# Disable VSCode from calling the mothership
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export REDIS_HOME=$APP_HOME/redis-6.0.6
export DART_HOME=/usr/lib/dart
export DART_TOOLS_HOME=$APP_HOME/flutter/bin/cache/dart-sdk
export PUB_TOOLS_HOME=$HOME/snap/flutter/common/flutter/.pub-cache
export PIP_TOOLS=$HOME/.local
export EMACS_DOOM_HOME=$HOME/.emacs.d/bin
export EMACS_HOME=$APP_HOME/emacs-27.2/bin/src
export SBT_HOME=$APP_HOME/sbt
# Android
export PATH=$HOME/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$PUB_TOOLS_HOME/bin:$PATH
# Flutter
export PATH=$APP_HOME/flutter/bin:$PATH
# Scala
export PATH=$SBT_HOME/bin:$PATH
# Node
export PATH=$NODE_HOME/bin:$YARN_HOME/bin:$EMACS_HOME:$EMACS_DOOM_HOME:$PATH
# Other programming tools
export PATH=$GO_HOME/bin:$PROTOBUF_HOME/bin:$GOBIN:$CARGO_HOME/bin:$APP_HOME/selenium:$VISUALVM_HOME/bin:$HOME/local/bin:$PIP_TOOLS/bin:$PATH
export PATH=$REDIS_HOME/src:$IDEA_HOME/bin:$PATH
# Setting rg as the default source for fzf
export FZF_DEFAULT_COMMAND='rg --files --vimgrep'
export FZF_CTRL_T_COMMAND='rg --files'
# Use bat to get colorized man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export TERM=xterm-256color
export TERMINAL=st
# Don't load ranger defaults in /etc/ranger/config
export RANGER_LOAD_DEFAULT_RC=FALSE
# fix segfault in dmenu
# export LANG='en_US.utf8'

LESSOPEN="|$APP_HOME/lesspipe/lesspipe.sh %s"; export LESSOPEN
