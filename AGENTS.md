# Repository Guidelines

## Project Structure & Module Organization
- `init.lua`: Entry point; sets leaders and loads `core` + `plugins`.
- `lua/core/`: Editor defaults and shared keymaps (`options.lua`, `keymaps.lua`).
- `lua/plugins/init.lua`: lazy.nvim setup and plugin list; requires per‑plugin modules.
- `lua/plugins/*.lua`: One file per plugin or feature (`lsp.lua`, `cmp.lua`, `telescope.lua`, `nvim-tree.lua`, `treesitter.lua`, `ai.lua`).
- `lazy-lock.json`: Pins plugin versions. Commit changes when plugins update.
- `install.sh`: Installer to symlink/copy into `~/.config/nvim`.

## Build, Test, and Development Commands
- Install locally: `./install.sh`
- Sync/update plugins: `:Lazy sync` (in Neovim) or `nvim --headless '+Lazy! sync' '+qall'`.
- Health checks: `:checkhealth` for environment; `:LspInfo` for LSP status; `:Mason` to manage servers.
- Run clean session for debugging: `nvim -u init.lua --noplugin` (or temporarily disable a plugin in `lua/plugins/init.lua`).

## Coding Style & Naming Conventions
- Language: Lua; 4‑space indentation (`expandtab=true`, `shiftwidth=4`).
- Modules: lowercase filenames; keep plugin config isolated (e.g., `lua/plugins/nvim-tree.lua`) and referenced from `plugins/init.lua` via `require('plugins.nvim-tree')`.
- Keymaps: use `vim.keymap.set(..., { desc = 'clear, action‑oriented description' })`.
- Prefer `local` variables; avoid globals and side effects outside module setup.
- Keep options in `core`, plugin behavior in `plugins`; don’t mix concerns.

## Testing Guidelines
- Headless smoke test: `nvim --headless '+Lazy! sync' '+qall'` (should exit cleanly).
- Interactive verification: open representative files (Lua, Python, TS); confirm Treesitter highlighting, LSP attach, Telescope and Nvim‑tree keymaps.
- When adding/upgrading plugins: run `:Lazy sync`, exercise basic flows, and commit the updated `lazy-lock.json`.

## Commit & Pull Request Guidelines
- Commit style: Conventional Commits (`feat:`, `fix:`, `docs:`, `refactor:`, `chore:`). Example: `fix: migrate to Neovim 0.11+ LSP API`.
- PR checklist: concise summary, rationale, affected modules (`core`/`plugins`), new/changed keymaps, screenshots for UI changes, and confirmation that `:checkhealth` passes and `:Lazy` reports no errors.
- Keep PRs focused; prefer smaller, incremental changes.

## Security & Configuration Tips
- Do not commit tokens or machine‑specific files; Codeium auth is user‑local (`:Codeium Auth`).
- Keep `lazy-lock.json` in version control to ensure reproducible plugin versions.
