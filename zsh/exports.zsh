export KEYTIMEOUT=50 # make zsh vi mode switch faster
export BROWSER=open
export EDITOR=nvim
export VISUAL=$EDITOR
export GOPATH=$HOME/Code/Go
export GOBIN=$GOPATH/bin
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND='rg --files'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export TERM=screen-256color
export SBT_OPTS="-Xms1G -Xmx4G -Dsbt.repository.config=sbt.repositories"
# for usage with dynamodb-admin
export DYNAMO_ENDPOINT=http://localhost:4566 
export AWS_DEFAULT_PROFILE=mercury-test
export AWS_REGION=us-east-1
CARGO_HOME=$HOME/.cargo
APP_HOME=$HOME/apps
COURSIER_HOME=$HOME/Library/Application\ Support/Coursier
PYTHON_PATH=/opt/homebrew/opt/python@3.10
JENV_HOME=$HOME/.jenv
GEMS=/opt/homebrew/lib/ruby/gems/3.1.0/bin
RUBY=/opt/homebrew/opt/ruby/bin

export PATH=/opt/homebrew/bin:$JAVA_HOME/bin:$COURSIER_HOME/bin:$GOBIN:$PYTHON_PATH/bin:$CARGO_HOME/bin:$APP_HOME/bin:$GEMS:$RUBY:$JENV_HOME/bin:$PATH


