;; Install with Forge before launching the Steel-enabled Helix build:
;; forge pkg install --git https://github.com/Ra77a3l3-jar/oil.hx.git
;; Stock Helix ignores this file. No custom keybindings are installed.
(require "oil/oil.scm")

;; Match mini.files' initial visibility: show dotfiles, hide git-ignored files.
(oil-configure! #true #false)
