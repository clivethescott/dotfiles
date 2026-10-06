# Helix plugin setup

This configuration carries over language tooling from your Neovim setup.
Shortcuts are unchanged and OCaml is omitted. `config.toml` selects the custom
`nvim_dark_custom` theme, which maps Neovim's default dark palette and your
`plugin/colors.lua` overrides to Helix scopes. The two editors' highlight groups
differ, so the result is an approximation rather than a pixel-identical copy.

## Configured now

`languages.toml` merges with Helix's built-in language definitions:

- Python: Ty for types and Ruff for linting, code actions, and formatting.
- JS/TS/JSX/TSX: TypeScript language server plus Biome; Biome handles formatting.
- Go: gopls with your analysis/hint settings and gofumpt formatting.
- Rust: rust-analyzer with your workspace symbol settings; formatting on save.
- Lua, Typst, Helm, Haskell, YAML: your applicable language server settings.
- Markdown, Gleam, Hurl: Prettier, Gleam, and hurlfmt formatting on save.
- Smithy: no formatting on save, matching your exception in Neovim.

Helix formats before saving, whereas your Conform config formats after saving.
Ruff import organization is available through code actions, rather than an
automatic second formatter. The Markdown formatter does not run markdownlint or
markdown-toc. Go uses gofumpt without the redundant follow-up gofmt step.
YAML uses the language server's SchemaStore integration; it does not reproduce
your selected schema subset or your work machine's local values schema.

Executables come from `PATH`. Your current shell already exposes Mason's tools,
so these settings reuse them. Helix itself does not install language servers.
Keep Mason's bin directory on `PATH` if you continue using those installations.

Reload an open editor with `:config-reload`; restart it to restart language servers.
For executable and parser checks, run `hx --health python` or another language name.

## Install experimental Steel and Oil

The installed Homebrew `hx` is Helix 25.07.1. For Steel plugins, build the
[`steel-event-system` fork](https://github.com/mattwparas/helix/blob/steel-event-system/STEEL.md).
The documented installer builds Helix, Steel, Forge, and the Steel language server.
Rust/Cargo is already available on this machine.

Run these commands in your terminal (the checkout path can be changed):

```sh
git clone --branch steel-event-system https://github.com/mattwparas/helix.git /Users/clive/Code/helix-steel
cd /Users/clive/Code/helix-steel
cargo xtask steel
/Users/clive/.cargo/bin/forge pkg install --git https://github.com/Ra77a3l3-jar/oil.hx.git
```

Ensure `/Users/clive/.cargo/bin` is on `PATH` before running the installer, since
it invokes Forge internally. The installer writes binaries there; the Homebrew
binary can still be selected separately at `/opt/homebrew/bin/hx`.

Launch the new binary with its matching runtime. This external `env` invocation
also works in Nushell:

```sh
env HELIX_RUNTIME=/Users/clive/Code/helix-steel/runtime /Users/clive/.cargo/bin/hx
```

Use that invocation from a project directory to edit that project. If you later
want plain `hx` to launch the new build, put Cargo's bin directory before
Homebrew's on `PATH` and configure `HELIX_RUNTIME` in your shell. Mixing the fork's
binary with Homebrew's runtime can cause missing or incompatible queries.

The prepared `helix.scm` and `init.scm` load Oil without custom keybindings.
Install Oil before the first launch: `init.scm` requires its module at startup.
Stock Helix ignores these Scheme files.

Use `:oil` to browse, `:oil-enter` to open an entry, `:oil-up` for the parent,
and `:oil-save` to apply filesystem edits. Ordinary `:write` is not the command
for applying Oil edits. `:oil-refresh` discards pending edits, and `:oil-close`
closes the browser. Dotfiles initially appear; git-ignored files are hidden.
Forge pulls in Oil's `notify.hx` dependency automatically.
See the [Oil README](https://github.com/Ra77a3l3-jar/oil.hx) for the other commands.

The fork and Oil have not been installed or executed here: command-line network
access is unavailable in this session. Their setup follows the linked upstream
instructions; the language configuration was checked using the installed Helix.

## Other Neovim plugins

| Neovim plugin                   | Helix equivalent / remaining work                                                                                       |
| ------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| nvim-treesitter and textobjects | Built-in parsing, highlighting, structural selections and textobjects                                                   |
| blink.cmp                       | Built-in LSP completion                                                                                                 |
| Snacks / fzf-lua pickers        | Built-in file, buffer, symbol, diagnostic and search pickers                                                            |
| mini.files                      | Prepared Oil plugin; requires the Steel installation above                                                              |
| conform.nvim                    | Built-in formatter/LSP support configured above                                                                         |
| mason.nvim                      | Reuse tools on PATH; no package manager configured in Helix                                                             |
| nvim-metals                     | Built-in Metals LSP connection; Neovim-specific UI is not ported                                                        |
| gitsigns                        | Built-in diff gutter and hunk navigation; staging/blame UI not added                                                    |
| diffview / gitlinker            | Not ported                                                                                                              |
| obsidian.nvim                   | Not ported; [markdown-oxide](https://github.com/Feel-ix-343/markdown-oxide) is an optional notes LSP with Helix support |
| render-markdown                 | Not ported; syntax highlighting does not reproduce its rendering                                                        |
| hurl.nvim                       | Hurl highlighting/formatting available; request runner not ported                                                       |
| crates.nvim                     | Not ported; Cargo dependency features need a separate solution                                                          |
| terminal and tmux integrations  | Not ported                                                                                                              |

Additional plugins should be chosen individually rather than loading Neovim Lua
plugins into Helix. Steel plugins use Scheme and the experimental Helix API.
