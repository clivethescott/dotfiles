if status is-interactive; and test -f $__fish_config_dir/themes/Catppuccin\ Macchiato.theme
  fish_config theme choose "Catppuccin Macchiato"
end

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

if type -q nvim
  abbr -a -g vim nvim
  abbr -a -g vi 'nvim -u ~/dotfiles/nvim/fast.luva'
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

if status is-interactive; and test -f ./tokens.fish
  source ./tokens.fish
end
 
set -gx EDITOR nvim
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

set PATH /opt/homebrew/bin /Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home $HOME/Library/Application\ Support/Coursier/bin $HOME/.cargo/bin $HOME/apps/bin $PATH

