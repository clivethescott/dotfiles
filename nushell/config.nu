# config.nu
#
# Installed by:
# version = "0.103.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.
alias k = kubectl

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
# mkdir ~/.cache/carapace
# carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
source ~/.cache/carapace/init.nu

mkdir ($nu.data-dir | path join "vendor/autoload")

# Starship prompt
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

$env.EDITOR = 'nvim'
$env.config = {
    show_banner: false,
    edit_mode: 'vi',
    cursor_shape: {
      emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line (line is the default)
      vi_insert: line # block, underscore, line , blink_block, blink_underscore, blink_line (block is the default)
      vi_normal: block # block, underscore, line, blink_block, blink_underscore, blink_line (underscore is the default)
    }
}

# Atuin shell history
# https://docs.atuin.sh/configuration/key-binding/#nu
$env.ATUIN_NOBIND = true
atuin init nu | save -f ~/.local/share/atuin/init.nu
source ~/.local/share/atuin/init.nu

# https://www.nushell.sh/book/line_editor.html#keybindings
$env.config.keybindings ++= [
  {
    name: atuin
    modifier: control
    keycode: char_r
    mode: [emacs, vi_normal, vi_insert]
    event: { send: executehostcommand cmd: (_atuin_search_cmd) }
  },
  {
    name: complete_history
    modifier: control
    keycode: char_y
    mode: [emacs, vi_normal, vi_insert]
    event: { send: HistoryHintComplete }
  }
]
