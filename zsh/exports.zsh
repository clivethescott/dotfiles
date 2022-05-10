export BROWSER=/usr/bin/firefox
export MYVIMRC=$HOME/.vim/vimrc
export APP_HOME=$HOME/apps
export VISUALVM_HOME=$APP_HOME/visualvm
export IDEA_HOME=$APP_HOME/intellij
export CARGO_HOME=$HOME/.cargo
export EDITOR=nvim
export VISUAL=$EDITOR
export HOSTALIASES=$HOME/.hosts
export GOPATH=$HOME/Code/Go
export GOBIN=$GOPATH/bin
export PROTOBUF_HOME=$APP_HOME/protobuf-compiler
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export REDIS_HOME=/opt/homebrew/opt/redis
export PIP_TOOLS=$HOME/.local
export SBT_HOME=$APP_HOME/sbt
export GO_HOME=$APP_HOME/go
export COURSIER_HOME=$HOME/Library/Application\ Support/Coursier
# Postgres
# Sublime
export SUBLIME_HOME='/Applications/Sublime Text.app/Contents/SharedSupport/bin'
# Java, Scala
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH=$JAVA_HOME/bin:$SBT_HOME/bin:$COURSIER_HOME/bin:$PATH
# Other programming tools
export PATH=$GO_HOME/bin:$PROTOBUF_HOME/bin:$GOBIN:$CARGO_HOME/bin:$APP_HOME/selenium:$VISUALVM_HOME/bin:$HOME/local/bin:$PIP_TOOLS/bin:$PATH
export PATH=$REDIS_HOME/bin:$IDEA_HOME/bin:$PATH
# Setting rg as the default source for fzf
# export FZF_DEFAULT_COMMAND='rg --files --vimgrep'
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND='rg --files'
# Use bat to get colorized man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export TERM=screen-256color
# Don't load ranger defaults in /etc/ranger/config
export RANGER_LOAD_DEFAULT_RC=FALSE
# fix segfault in dmenu
# export LANG='en_US.utf8'
export PATH=/opt/homebrew/opt/python@3.10/bin:/opt/homebrew/bin:$PATH
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"

LESSOPEN="|$APP_HOME/lesspipe/lesspipe.sh %s"; export LESSOPEN
