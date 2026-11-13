# Kitty without tmux

The config uses Ghostty's Nvim Dark palette, JetBrainsMono NFM at 17pt,
red cursor, dimmed inactive panes, automatic clipboard selection and Fish.
The tab bar is at the top, like your WezTerm and tmux configurations.
The previous Kitty config is in kitty.conf.before-port.

Restart Kitty to apply the startup session, decorations, shell and Option-key
settings. After that, Cmd+Shift+R or leader+r reloads ordinary config changes.

## Keys

Leader means press Cmd+A, release it, then press the listed key.
Escape cancels a pending sequence. Cmd+A then Cmd+A sends Ctrl+A.
Most other Cmd+letters send Ctrl+letters, matching your Ghostty setup.
Use Cmd+Shift+C/V for clipboard copy/paste, and Cmd+Option+Q to quit.

| After leader | Action |
| --- | --- |
| v / s | Split right / below |
| h / j / k / l | Focus left / down / up / right |
| H / J / K / L | Shrink width / shrink height / grow height / grow width |
| z | Zoom active pane; repeat to restore splits |
| Space | Switch splits/stack layout |
| = | Reset pane sizes |
| f | Pick a pane visually |
| { | Pick a pane to swap with |
| q / X | Close pane (asks before closing a running command) |
| c | New tab in current directory and session |
| C | New tab, then prompt for its title |
| , | Rename tab |
| n / p | Next / previous tab |
| Tab | Last active tab |
| 1–9 | Select tab |
| t | Tab picker |
| g | Lazygit tab in current directory |
| m / M | Move pane to new tab / OS window |
| N / u | New OS window / toggle maximized |
| x | URL hints |
| backslash | Path hints |
| [ or / | Scrollback pager; / searches, n repeats, q exits |
| P | Paste clipboard |
| r | Reload config |
| : | Command palette |
| o | Browse saved session files |
| 0 | Pick an active session |
| - | Previous session |
| S | Save this session under a new filename |
| Ctrl+S | Update this session's file |

Outside the leader: Option+N/P changes tabs, Cmd+arrows resizes panes,
Cmd+Shift+D moves a pane to a new tab, Cmd+Shift+F opens scrollback.
Cmd+- decreases font size, Cmd+= increases it, Cmd+Shift+= resets it.
Option+3 produces # on your UK keyboard. Shift+Enter sends Escape+Return.

## Named projects / sessions

Kitty starts maximized in sessions/home.kitty-session. The bar includes the
session filename (without its suffix), tab number/title, and [Z] when zoomed.
Tabs from other sessions are hidden until you switch to that session.

For a new project, copy sessions/home.kitty-session to, for example,
sessions/my-project.kitty-session. Change its cd line to the project directory
and its new_tab line to the desired tab title. Open it with leader+o.
You can also start directly with:

    /Applications/kitty.app/Contents/MacOS/kitty --session ~/.config/kitty/sessions/my-project.kitty-session

After arranging tabs/splits, leader+Ctrl+S updates the current session file.
Leader+S prompts for a new path under sessions/; use a .kitty-session suffix,
then open that saved file with leader+o to work under its new name.
Saving opens the session file in your editor for review.
Saving currently records shells/directories/layouts; it does not capture the
foreground program inside each shell. Add --use-foreground-process to the
save_as_session mappings if you want to save editor/REPL launch commands.

Kitty sessions recreate layouts and launch commands. They do not keep processes
alive after quitting Kitty or provide tmux-style detach/reattach.
The existing sesh/tmux session picker and tmux-resurrect are not used here.
There is no global quick-terminal shortcut port in this config.

## References

- https://sw.kovidgoyal.net/kitty/sessions/
- https://sw.kovidgoyal.net/kitty/conf/
- https://sw.kovidgoyal.net/kitty/layouts/#the-splits-layout
