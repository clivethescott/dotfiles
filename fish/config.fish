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

# bind fzf
# bind --user to see configured, e.g \E is meta+shift+e
fzf_configure_bindings --history= --git_status= --variables= --git_log=\eG --directory=\ef --processes=\eP
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
if status is-interactive; and not set -q TMUX
  if tmux has-session -t home
    exec tmux attach-session -t home
  else
   tmux new-session -s home
  end
end

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

# setup homebrew
fish_add_path "/opt/homebrew/bin/"
# Setup brew
eval "$(/opt/homebrew/bin/brew shellenv)"


abbr -a -g lg lazygit
abbr -a -g gd 'git diff'
abbr -a -g gs 'git status'
abbr -a -g gp 'git push'
abbr -a -g dashlane dcli
abbr -a -g jless 'jless --relative-line-numbers'
abbr -a -g jv 'jira issue view'


if type -q nvim
  abbr -a -g vim nvim
  abbr -a -g vi 'nvim -u ~/dotfiles/nvim/fast.lua'
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

if status is-interactive; and test -f ~/.config/fish/tokens.fish
  source ~/.config/fish/tokens.fish
end
 
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx FZF_DEFAULT_OPTS "--layout reverse --tmux 80% --border --bind 'alt-i:toggle-preview' --bind 'ctrl-/:change-preview-window(down|hidden|)' --walker-skip .git,node_modules,target,.scala-build"
set -gx FZF_DEFAULT_COMMAND "fd --type file --strip-cwd-prefix --follow --exclude .git"
set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home"
set -gx BAT_THEME OneHalfDark

# Add completions from stuff installed with Homebrew.
if test "$os" = Darwin
    if test -d "/opt/homebrew/share/fish/completions"
        set -p fish_complete_path /opt/homebrew/share/fish/completions
    end
    if test -d "/opt/homebrew/share/fish/vendor_completions.d"
        set -p fish_complete_path /opt/homebrew/share/fish/vendor_completions.d
    end
end

# fzf --fish | source

set PATH /opt/homebrew/bin $JAVA_HOME/bin $HOME/Library/Application\ Support/Coursier/bin $HOME/.cargo/bin $HOME/apps/bin $PATH

