# Add Homebrew provide shell completions
# https://docs.brew.sh/Shell-Completion
FPATH="$(/opt/homebrew/bin/brew --prefix)/share/zsh/site-functions:/Users/clive/.zsh/completion:${FPATH}"



# >>> JVM installed by coursier >>>
export JAVA_HOME="/Users/clive/Library/Caches/Coursier/arc/https/cdn.azul.com/zulu/bin/zulu17.40.19-ca-jdk17.0.6-macosx_aarch64.tar.gz/zulu17.40.19-ca-jdk17.0.6-macosx_aarch64"
# <<< JVM installed by coursier <<<
