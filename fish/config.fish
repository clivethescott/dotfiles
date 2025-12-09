if status is-interactive; and test -f $__fish_config_dir/themes/Catppuccin\ Macchiato.theme
    fish_config theme choose "Catppuccin Macchiato"
end

set -gx EDITOR nvim
set -gx COMPOSE_BAKE true
set -gx JIRA_PAGER bat

# Disable the fish greeting message
set fish_greeting ""
# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursors to an underscore
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
# Set the external cursor to a line. The external cursor appears when a command is started.
# The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
set fish_cursor_external line
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block
# more info in prompt
set fish_prompt_pwd_full_dirs 2
set fish_prompt_pwd_dir_length 3
# vi-mode
set -g fish_key_bindings fish_vi_key_bindings

# set fzf_directory_opts --bind "ctrl-y:execute($EDITOR {}) ctrl-f:reload(fd --type file)"

set -gx FZF_DEFAULT_OPTS "--layout reverse --tmux 80% --border --bind 'alt-i:toggle-preview' --bind 'ctrl-/:change-preview-window(down|hidden|)' --walker-skip .git,node_modules,target,.scala-build,.idea"
set -gx FZF_DEFAULT_COMMAND "fd --type file --strip-cwd-prefix --follow --exclude .git"
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_CTRL_T_OPTS $FZF_DEFAULT_OPTS
if status is-interactive; and type -q fzf
    fzf --fish | FZF_CTRL_R_COMMAND= FZF_ALT_C_COMMAND= source
    # https://junegunn.github.io/fzf/
    abbr --add -g gco "git branch | fzf --preview 'git show --color=always {-1}' \
--bind 'enter:become(git switch {-1})' \
--height 40% --layout reverse"
end

# setup atuin
if status is-interactive; and type -q atuin
    # disable default keybindings
    set -gx ATUIN_NOBIND true
    atuin init fish | source
end

# tmux auto-start
#if status is-interactive; and set -q TMUX
#  if tmux has-session -t home
#    exec tmux attach-session -t home
#  else if tmux has-session -t subscription
#    exec tmux attach-session -t subscription
#  end
#end

# auto-suggestion mappings
if status is-interactive
    for mode in insert default visual
        # mimic right key to complete auto-suggestion
        # disable the preset in fish_user_key_bindings or may get reset
        bind -M $mode \cy forward-char
        # bind -M $mode \ce forward-char
    end
end

# history + atuin
if status is-interactive
    bind \cr _atuin_search
    for mode in insert visual
        bind -M $mode \cr _atuin_search
        bind -M $mode \cn history-prefix-search-forward
        bind -M $mode \cp history-prefix-search-backward
    end
end

# edit commands in vim
if status is-interactive
    for mode in default visual insert
        bind -M $mode \ce edit_command_buffer
    end
    for mode in default visual
        bind -M $mode vv edit_command_buffer
    end
end

#bind -M insert ctrl-c __fish_cancel_commandline

# setup coreutils. This is slighly better than the mise one which has 1 uber command
fish_add_path /opt/homebrew/opt/uutils-coreutils/libexec/uubin
fish_add_path /opt/homebrew/bin/
fish_add_path "$HOME/.docker/bin"

if type -q brew
# Setup brew
  eval "$(/opt/homebrew/bin/brew shellenv)"
end

if type -q sd
    abbr -a sed sd
end

if type -q gron
    abbr -a gr gron
    abbr -a ungron gron --ungron
end

# if type -q mise
#   mise activate fish | source
# end
#
if type -q uv
    abbr -a pip uv pip
    abbr -a pip3 uv pip
end

if type -q lazygit
    abbr -a lg lazygit
end

if type -q lazydocker
    abbr -a lld lazydocker
end

abbr -a gd 'git diff'
abbr -a gs 'git status --short'
abbr -a gp 'git pull --ff --quiet'
abbr -a gP 'git push'
abbr -a gwl 'git worktree list'
abbr -a gwr 'git worktree remove'
abbr -a gwa 'git worktree add'
abbr -a gw 'git worktree'
abbr --add unset 'set --erase'
abbr --add pbclear pbcopy < /dev/null

if type -q kubectl
    abbr -a k kubectl
    abbr -a kgetcontext kubectl config current-context
    abbr -a ksetcontext kubectl config use-context
    abbr -a ksetnamespace kubectl config set-context --current --namespace=
end

if type -q dcli
    abbr -a dashlane dcli
end

if type -q jira
    abbr -a jv 'jira issue view'
end

if type -q jless
    abbr -a jless 'jless --relative-line-numbers'
    abbr -a yless 'jless --relative-line-numbers --yaml'
end

if type -q terraform
    abbr -a tf terraform
end

if type -q gitui
    abbr -a gt gitui
end

if type -q xh
    abbr -a http xh
end

function z
  cd
end

if type -q nvim
    abbr -a vim nvim
    abbr -a nv nvim
    abbr -a nvi nvim
    abbr -a vi 'nvim -u NONE'
end

# `ls` → `lsd`
if type -q lsd
    abbr --add -g ls lsd
end

# `cat` → `bat` abbreviation
# Requires `brew install bat`
if type -q bat
    abbr --add -g cat bat
    # https://github.com/sharkdp/bat#highlighting---help-messages
    abbr -a --position anywhere -- --help '--help | bat -plhelp'
    abbr -a --position anywhere -- -h '-h | bat -plhelp'
end

if type -q ast-grep
    abbr --add -g sg ast-grep
end

if type -q gh
    abbr --add -g ghr 'gh pr checkout'
end

if type -q python3
    abbr --add -g py python3
    abbr --add -g python python3
end

if status is-interactive; and test -f ~/.config/fish/tokens.fish; and not set -q USE_Q
    source ~/.config/fish/tokens.fish
end

set -gx MANPAGER "sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
#set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home"
set -gx JAVA_HOME (which java | sed 's#/bin/java##')
set -gx BAT_THEME "Catppuccin Mocha"
#set -gx SBT_OPTS "-XX:MaxMetaspaceSize=2G XX:ReservedCodeCacheSize=256M -XX:+UseZGC -Xms1G -Xmx4G -Xss8M -Dsbt.repository.config=sbt.repositories"
set GOBIN $HOME/Code/Go/bin
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx TEALDEER_CONFIG_DIR $HOME/.config/tealdeer
set -gx PYTHONGIL 0
abbr -a tldr tldr -p macos --pager
abbr -a -g sbtd 'sbt -Dsbt.server.autostart=false'

# Add completions from stuff installed with Homebrew.
if status is-interactive; and test "$os" = Darwin
    if test -d /opt/homebrew/share/fish/completions
        set -p fish_complete_path /opt/homebrew/share/fish/completions
    end
    if test -d "/opt/homebrew/share/fish/vendor_completions.d"
        set -p fish_complete_path /opt/homebrew/share/fish/vendor_completions.d
    end
end

# carapace completion
# set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
# carapace _carapace | source

# fzf --fish | source
if status is-interactive; and type -q zoxide
    # import from z => zoxide import --merge --from=z ~/.local/share/z/data
    set -gx _ZO_FZF_OPTS "$FZF_DEFAULT_OPTS"
    # z, zi for fzf
    zoxide init --cmd cd fish | source
    abbr -a z cdi
end

set PATH /opt/homebrew/bin $GOBIN $HOME/Library/Application\ Support/Coursier/bin $HOME/.cargo/bin $HOME/apps/bin $JAVA_HOME/bin $PATH

fish_add_path ~/.local/bin
fish_add_path /opt/homebrew/opt/git/share/git-core/contrib/git-jump
