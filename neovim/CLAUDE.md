# Neovim config

- Plugins are `vim.pack.add` calls in `plugin/*.lua`; the lock file is `nvim-pack-lock.json`.
- Archive a plugin: `git mv` its file to `.archived/`, then `nvim --headless -c 'lua vim.pack.del({"<name>"})' -c qa`, then confirm the entry is gone from the lock file.
- Headless nvim installs plugins and rewrites the lock file. Read `git diff nvim-pack-lock.json` before committing and ask which bumps are the user's.
- Replacing a plugin: port its mappings one-for-one. Flag any with no equivalent instead of dropping them.
