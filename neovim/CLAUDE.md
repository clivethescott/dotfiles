# Neovim Dotfiles

## Plugin Manager

Uses [`lz.n`](https://github.com/nvim-neorocks/lz.n) with Neovim's built-in `vim.pack` (`:h packadd`).

Plugins are declared in `init.lua` using the `gh()` helper (short for GitHub), which registers a plugin spec. Lock file: `nvim-pack-lock.json`.

## Directory Structure

```
init.lua                  # Plugin declarations (gh() calls) and bootstrap
plugin/                   # Auto-loaded on startup (no require needed)
  options.lua             # vim.opt settings
  keymaps.lua             # Global keymaps
  autocommands.lua        # Global autocommands
  colors.lua              # Colorscheme config
lua/
  deps/                   # Per-plugin lazy config files (<name>.lua)
  lsp.lua                 # LSP shared module (on_attach, capabilities)
  utils.lua               # Shared utility functions
after/
  ftplugin/               # Language-specific settings (<filetype>.lua)
  lsp/                    # Per-LSP server overrides (<server>.lua)
```

## Adding or Modifying Plugins

1. Add a spec in `init.lua` using `gh("owner/repo", { ... })`.
2. Create `lua/deps/<name>.lua` returning a table with:
   - `after` — function called when the plugin loads
   - `event`, `ft`, `keys`, `cmd` — lazy-loading triggers (optional)
   - `dependencies` — list of plugin names to load first (optional)

Example:

```lua
-- init.lua
gh("echasnovski/mini.surround", { config = true })

-- lua/deps/mini-surround.lua
return {
  ft = { "lua", "python" },
  after = function()
    require("mini.surround").setup()
  end,
}
```

## LSP

`lua/lsp.lua` exports:
- `M.on_attach(client, bufnr)` — attach keymaps and capabilities per buffer
- `M.client_capabilities()` — merged capabilities table

To add a new LSP server:
1. Add the server name to the list in `lua/deps/lspconfig.lua`.
2. Optionally create `after/lsp/<server>.lua` to return overrides (e.g. `settings`, `filetypes`).

## Environment Flag

`vim.g.is_work_pc` (boolean) controls work-specific features:
- Copilot integration
- Obsidian vault/workspace selection

Set this in your local machine config before sourcing the dotfiles.

## Key Conventions

- **Leader key**: `,`
- **`<space>` keymaps**: two-character mnemonics (e.g. `<space>ff` for find files)
- Filetype-specific maps go in `after/ftplugin/<ft>.lua`
