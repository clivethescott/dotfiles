if status is-interactive; and test -f $__fish_config_dir/themes/Catppuccin\ Macchiato.theme
  fish_config theme choose "Catppuccin Macchiato"
end

set -gx EDITOR nvim

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

# https://github.com/PatrickF1/fzf.fish
# bind --user to see configured, e.g \E is meta+shift+e

fzf_configure_bindings --history= --git_status=\eG --variables= --git_log= --directory=\eF --processes=\eP
set fzf_diff_highlighter delta --paging=never --width=20 # should not pipe its output to a pager
set fzf_fd_opts --max-depth 5
set fzf_preview_dir_cmd lsd -l --color always
# open file in $EDITOR
set fzf_directory_opts --bind "ctrl-y:execute($EDITOR {})"

# setup atuin
if status is-interactive
  # disable default keybindings
  set -gx ATUIN_NOBIND "true"
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
    bind -M $mode \ce forward-char
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
  for mode in default visual
    bind -M $mode vv edit_command_buffer
  end
end

#bind -M insert ctrl-c __fish_cancel_commandline

# setup homebrew
fish_add_path "/opt/homebrew/bin/"
# Setup brew
eval "$(/opt/homebrew/bin/brew shellenv)"


abbr -a -g lg lazygit
abbr -a -g gd 'git diff'
abbr -a -g gs 'git status'
abbr -a -g gp 'git push'
abbr -a -g dashlane dcli
abbr -a -g jv 'jira issue view'

if type -q jless
  abbr -a -g jless 'jless --relative-line-numbers'
  abbr -a -g yless 'jless --relative-line-numbers --yaml'
end

if type -q terraform
  abbr -a -g tf terraform
end

if type -q gitui
  abbr -a -g gt gitui
end

if type -q xh
  abbr -a -g http xh
end

if type -q nvim
  abbr -a -g vim nvim
  abbr -a -g nv nvim
  abbr -a -g vi 'nvim -u NONE'
end
 
# `ls` → `lsd`
if type -q lsd
  abbr --add -g ls 'lsd'
end
 
# `cat` → `bat` abbreviation
# Requires `brew install bat`
if type -q bat
  abbr --add -g cat 'bat'
end

if type -q ast-grep
  alias sg ast-grep
end

if type -q fzf
  # https://junegunn.github.io/fzf/
  abbr --add -g gco "git branch | fzf --preview 'git show --color=always {-1}' \
--bind 'enter:become(git switch {-1})' \
--height 40% --layout reverse"
end

if type -q gh
  abbr --add -g ghr 'gh pr checkout'
end

if type -q python3
 abbr --add -g py python3
end

if status is-interactive; and test -f ~/.config/fish/tokens.fish
  source ~/.config/fish/tokens.fish
end
 
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx FZF_DEFAULT_OPTS "--layout reverse --tmux 80% --border --bind 'alt-i:toggle-preview' --bind 'ctrl-/:change-preview-window(down|hidden|)' --walker-skip .git,node_modules,target,.scala-build"
set -gx FZF_DEFAULT_COMMAND "fd --type file --strip-cwd-prefix --follow --exclude .git"
#set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home"
set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/graalvm-jdk-21.0.6+8.1/Contents/Home"
set -gx BAT_THEME OneHalfDark
#set -gx SBT_OPTS "-XX:MaxMetaspaceSize=2G XX:ReservedCodeCacheSize=256M -XX:+UseZGC -Xms1G -Xmx4G -Xss8M -Dsbt.repository.config=sbt.repositories"
set GOBIN $HOME/Code/Go/bin
set -gx XDG_CONFIG_HOME $HOME/.config

# Add completions from stuff installed with Homebrew.
if status is-interactive; and test "$os" = Darwin
    if test -d "/opt/homebrew/share/fish/completions"
        set -p fish_complete_path /opt/homebrew/share/fish/completions
    end
    if test -d "/opt/homebrew/share/fish/vendor_completions.d"
        set -p fish_complete_path /opt/homebrew/share/fish/vendor_completions.d
    end
end

# fzf --fish | source
if status is-interactive; and type -q zoxide
# import from z => zoxide import --merge --from=z ~/.local/share/z/data
  set -gx _ZO_FZF_OPTS "$FZF_DEFAULT_OPTS"
# z, zi for fzf
  zoxide init fish | source
end

set PATH /opt/homebrew/bin $GOBIN $JAVA_HOME/bin $HOME/Library/Application\ Support/Coursier/bin $HOME/.cargo/bin $HOME/apps/bin $PATH
set PATH ~/orbstack/bin ~/.local/bin $PATH

# moonfly theme for the Fish shell
#
# Upstream: github.com/bluz71/vim-moonfly-colors

# Syntax highlighting colors.
set -g fish_color_autosuggestion 626262
set -g fish_color_cancel 626262
set -g fish_color_command 7cb3ff
set -g fish_color_comment 949494 --italics
set -g fish_color_cwd 87d787
set -g fish_color_cwd_root ff5189
set -g fish_color_end 949494
set -g fish_color_error ff5d5d
set -g fish_color_escape 949494
set -g fish_color_history_current c6c6c6 --background=323437
set -g fish_color_host e4e4e4
set -g fish_color_host_remote e4e4e4
set -g fish_color_keyword cf87e8
set -g fish_color_match c6c6c6 --background=323437
set -g fish_color_normal bdbdbd
set -g fish_color_operator e65e72
set -g fish_color_option bdbdbd
set -g fish_color_param 61d5ae
set -g fish_color_quote c6c684
set -g fish_color_redirection 8cc85f
set -g fish_color_search_match --background=323437
set -g fish_color_selection --background=323437
set -g fish_color_status ff5d5d
set -g fish_color_user 36c692
set -g fish_color_valid_path

# Completion pager colors.
set -g fish_pager_color_completion c6c6c6
set -g fish_pager_color_description 949494
set -g fish_pager_color_prefix 74b2ff
set -g fish_pager_color_progress 949494
set -g fish_pager_color_selected_background --background=323437
set -g fish_pager_color_selected_completion e4e4e4
set -g fish_pager_color_selected_description e4e4e4
