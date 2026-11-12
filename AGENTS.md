# AGENTS.md

## Overview

Personalized, cross-platform Vim configuration (Windows + Linux/Debian), primarily VimL. The repo holds **only configuration**; plugins, undo history, swap and backup files live in a separate runtime data directory so the repo stays clean.

## Setup

Clone to `~/.config/vim` (Linux, XDG) or `%USERPROFILE%\.config\vim` (Windows):

```bash
git clone https://github.com/VimWei/vim-init.git .config/vim
```

On Windows, link `vimfiles\vimrc` to `.config\vim\vimrc` (`vimrc` sources `~/.config/vim/init.vim`). Then run `:PlugInstall` in Vim, and pull submodules with `git submodule update --init --recursive` (or `:VV` / the `Update VIMRC` menu entry).

## Directory Structure

| Directory | Purpose |
|-----------|---------|
| `init/` | Core config files (loaded by `init.vim`) |
| `plugin-config/` | Plugin/package configs, named per plugin (`wiki.vim.vim` → `wiki.vim`) |
| `autoload/` | Custom autoload functions (`python.vim`, `DachuBook.vim`, `Vimrc.vim`, …) |
| `ftplugin/` | Filetype plugins (markdown, toml, yaml, javascript, …) |
| `colors/` | Color schemes |
| `after/plugin/` | Late-loaded overrides (e.g. `speeddating.vim`) |
| `pack/mydev/opt/` | Vim builtin packages, mostly git submodules |
| `tools/` | Dicts, Pandoc templates, spell files, syntax, helper scripts |

## Key Conventions

- **Leader key**: `<space>` (not `\`)
- `\ ` - Navigator key navigation (`:VN` edits its config)
- `<Leader><Leader>m` - Menu (`:VM` edits its config)
- `:VI` - Edit `init.vim`; `:VV`/`:VE`/`:VP`/`:VQ`/`:VK`/`:VC`/`:VG`/`:VM`/`:VN`/`:VA` edit the matching `init/` or `plugin-config/` file (see `init/autoload.vim`)
- `<Leader>gf` - Open the plugin config on the current line (works for both `Plug '…'` and `packadd! …`)
- Fold markers: `{{{1`, `{{{2`, … (standard VimL)

## Load Order

`init.vim` → `init/globals.vim` → `init/essential.vim` → `init/tabsize.vim` → `init/keymaps.vim` → `init/python.vim` → `init/plugins.vim` → `init/packages.vim` → `init/autoload.vim` → `init/guistyle.vim` → `init/statusline.vim` → `init/colorstyle.vim`

`init/minimal.vim` is a scratch config for testing and is **not** sourced.

## Plugin System

- **vim-plug** plugins are declared in `init/plugins.vim` inside groups (`basic`, `inbox`, `Notetaking`, `program`), gated by `IsInPlugGroup()`. Override `g:plug_group` **before** it loads to test a subset.
- **Builtin packages** are enabled in `init/packages.vim` via `packadd!`, each guarded by a version check (`has('patch-…')`).
- Both loaders then source `plugin-config/{name}.vim` for every enabled plugin/package that has a config file. A config only loads if the plugin is in `g:plugs_order` or `s:packages`, so adding a config file alone is not enough.

## Python/uv

`init/python.vim` sources `autoload/python.vim` directly and sets `g:python_available = v:true` early; `python#SetupDLL()` is deferred to `VimEnter`.

- `python#Detect()` probes Python cross-platform: on Linux it prefers the uv tool sandbox (`~/.local/share/uv/tools/vim-init`), then uv global, uv-managed CPython, pyenv, then system `python3`; on Windows it prefers `python` from PATH, then common install paths.
- `python#SetupDLL()` sets `$pythonthreedll` for GVim on Windows, reading `pyvenv.cfg` first.
- `g:python_venv_prog` is optional; if set, it takes precedence over detection.
- Feature gates use `get(g:, 'python_available', v:false)` — LeaderF, UltiSnips, SimpylFold, vim-repl, PinYin and the `:PyRun` mapping are skipped when Python is missing.

Dependencies are declared in `pyproject.toml` (currently `pypinyin`) and installed with uv:

```bash
uv venv && uv sync
# or, for the sandbox used by python#Detect():
uv pip install --requirement pyproject.toml --target ~/.local/share/uv/tools/vim-init
```

- `:PyRun` or `<F5>` - Run current buffer via `AsyncRun` + `uv run python`
- `python#Run(mode, cmd…)` - Generic async runner (`async` / `terminal` / `bang`)

## DachuBook

`:DachuBookPage [profile]` and `:DachuBookTree [profile]` render the current Markdown note to PDF through the external [DachuBook](https://gitea.vimel.org/Vimel/DachuBook) CLI. `autoload/DachuBook.vim` is a thin wrapper: it builds the command line and runs it through `AsyncRun` when available. The optional argument is a config profile name (`~/.config/dachubook/<name>.yaml`) or a path.

- `g:dachubook_cmd` (default `dachubook`), `g:dachubook_output` (default `<wiki_root>/.output`)
- Output filename is decided by the CLI (`output.name`, else the entry filename)
- Requires Pango/GTK at runtime (installed with WeasyPrint)

## Testing Changes

Files under `init/`, `autoload/` and `init.vim` auto-reload on save when the working directory is the repo (see `Vimrc#AutoReload`). Otherwise:

```vim
:source ~/.config/vim/init.vim
:PlugInstall
```

## Important Patterns

- `g:viminit` - Repo root, with a trailing `/` (forward slashes)
- `g:viminitparent` - Parent of the repo root (used by `plugin-config/vimwiki.vim`)
- `g:plugin_config_path` - `plugin-config/` directory
- `g:vim_data_dir` - Runtime data dir: `~/vimfiles/` on Windows, `~/.vim/` elsewhere; holds `plugged/`, `backup/`, `swap/` (created in `init/globals.vim`)
- `init/globals.vim` appends the repo and `after/` to `runtimepath`, and the repo to `packpath`

## Gotchas

- `set noshellslash` is required for vim-plug on Windows (set in `init/plugins.vim`, toggled around PlugBegin/PlugEnd)
- Windows path separators: use forward slashes in VimL (`/`) or double backslashes (`\\`)
- `pack/mydev/opt/` packages are git submodules (some use `git@github.com:` URLs); `reference/` and `tools/UltiSnips/` are gitignored
- Plugin configs only load if the plugin is present in `g:plugs_order` or `s:packages`
