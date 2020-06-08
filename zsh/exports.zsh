#export http_proxy='http://proxy.econet.co.zw:80'
#export https_proxy='http://proxy.econet.co.zw:80'
export MYVIMRC=/home/clive/.vim/vimrc
export DYNU_USER='clivethescott'
export EXPRESSVPN_EMAIL='clivegurure@gmail.com'
export APP_HOME=/home/clive/apps
export ANDROID_SDK_HOME=/home/clive/Android/Sdk
export ANDROID_HOME=$ANDROID_SDK_HOME
export YARN_HOME=/usr/share/yarn
export PATH=$HOME/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:/usr/bin:$PATH
export PATH=$PATH:$APP_HOME/flutter/bin:$YARN_HOME/bin
export DART_TOOLS_HOME=$APP_HOME/flutter/bin/cache/dart-sdk/bin
export VISUALVM_HOME=/home/clive/apps/visualvm
export PATH=$PATH:$HOME/.pub-cache/bin:$DART_TOOLS_HOME:$HOME/.local/bin:/opt/firefox/firefox:$VISUALVM_HOME/bin
# Path to your oh-my-zsh installation.
export IDEA_HOME=$APP_HOME/intellij
# export JAVA8_HOME=$APP_HOME/JDK/jdk-8
# export JAVA11_HOME=$APP_HOME/JDK/jdk-11
# export JAVA_HOME=$JAVA11_HOME
export M2_HOME=$APP_HOME/maven3
export NODE_HOME=$APP_HOME/node
export PATH=$NODE_HOME/bin:$PATH
export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$IDEA_HOME/bin:$PATH
export GO_HOME=$APP_HOME/go/bin
export PATH=$GO_HOME:$PATH
export EDITOR=nvim
export VISUAL=$EDITOR
export HOSTALIASES=$HOME/.hosts
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='rg --files --vimgrep'
export FZF_CTRL_T_COMMAND='rg --files'

LESSOPEN="|$APP_HOME/lesspipe/lesspipe.sh %s"; export LESSOPEN
