# Personal Doom configuration

Track these files together in dotfiles:

- `config.el`: all runtime customizations, language-server settings, formatter
  chains, completion preferences, theme, fullscreen, and modifier keys.
- `init.el`: enabled Doom modules and flags.
- `packages.el`: extra package declarations.
- `snippets/`: the eight personal snippets and their mode inheritance.
- `tests/config-test.el`: regression checks against the installed Emacs packages.

There are no configuration loaders or external settings data files. The old
`DOOM_SKIP_NVIM_PARITY` switch has been removed; use version control to roll back
changes. Runtime helper names retain their `nvim-parity-` prefix.

Run `~/.config/emacs/bin/doom sync` after changes to `init.el` or `packages.el`,
then restart Emacs. Runtime-only changes in `config.el` do not require sync.

The current theme is Tokyo Night with its default colours. GUI frames start in
fullscreen, both Option keys act as Meta, and Command acts as Control. Completion
preselects the first candidate after a 150ms pause. EditorConfig is enabled before
the first file is visited.

Language servers and formatters use project `node_modules/.bin` and `.venv/bin`
first, then `${XDG_DATA_HOME:-~/.local/share}/nvim/mason/bin`, then normal PATH
tools. Their runtimes (Node.js, a JDK, Go, Rust, and Nushell as applicable) must be
available too. Run `doom env` from your development shell if GUI Emacs cannot find
tools that are available there, then restart. Missing Python packages belong in
project virtual environments managed with `uv`.

Personal snippets:

| Mode | Triggers |
| --- | --- |
| All | `dateUTC`, `epoch` |
| Go | `iff` |
| Rust / Rustic | `printone`, `tys`, `tafn` |
| Scala | `fory` |
| Lua | `foo` |

Rust uses an independent shared snippet table to avoid a circular hierarchy.
Save formatting is enabled for Go, Rust, Python, JS/TS/JSX/TSX, and Markdown.
Markdown TOC updates use `<!-- toc -->` markers. Work-specific YAML schemas require
`IS_WORK_PC=true` and an existing `~/IdeaProjects/infra/values.schema.json`.

Run the local regression checks from this directory:

```sh
emacs -Q --batch -l tests/config-test.el -f ert-run-tests-batch-and-exit
```

These checks cover module/package declarations, first-file EditorConfig, deferred
LSP initialization, gopls configuration responses, binary resolution, formatting,
and snippet inheritance. They do not start live language servers.
