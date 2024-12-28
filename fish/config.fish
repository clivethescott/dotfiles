if status is-interactive
    # Commands to run in interactive sessions can go here
  # disable default keybindings
  set -gx ATUIN_NOBIND "true"
  atuin init fish | source

  # tmux
  if not set -q TMUX
    if tmux has-session -t home
	    exec tmux attach-session -t home
    else
     tmux new-session -s home
    end
  end
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
# vi-mode
set -g fish_key_bindings fish_vi_key_bindings

if status is-interactive
  for mode in insert default visual
    # mimic right key to complete auto-suggestion
    # disable the preset in fish_user_key_bindings
    bind -M $mode \cy forward-char

    # atuin
    bind \cr _atuin_search
    bind -M $mode \cn _atuin_bind_up
    bind -M $mode \cp _atuin_bind_up
    bind -M $mode \cr _atuin_search
  end

  for mode in default visual
    bind -M $mode vv edit_command_buffer
  end
end

# setup homebrew
fish_add_path "/opt/homebrew/bin/"
# Setup brew
eval "$(/opt/homebrew/bin/brew shellenv)"


abbr -a -g lg lazygit
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
 
set PATH /opt/homebrew/bin /Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home $HOME/Library/Application\ Support/Coursier/bin $HOME/.cargo/bin $HOME/apps/bin $PATH

