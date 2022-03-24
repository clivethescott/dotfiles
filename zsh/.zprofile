# Add Homebrew provide shell completions
# https://docs.brew.sh/Shell-Completion
FPATH="$(/opt/homebrew/bin/brew --prefix)/share/zsh/site-functions:$(cs --completions zsh):${FPATH}"

