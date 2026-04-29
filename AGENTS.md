# AGENTS.md

## Overview

Personalized Vim/Neovim configuration for Windows. Primary language is VimL; Neovim-specific configs go in `neovim.lua`.

## Setup

1. Clone to `d:\WeirdData\vim-init`
2. Create `c:\Users\YourName\vimfiles\`
3. Add to `vimrc`:
   ```
   source d:\WeirdData\vim-init\init.vim
   ```
4. Run `:PlugInstall` in Vim

## Directory Structure

| Directory | Purpose |
|----------|---------|
| `init/` | Core config files (loaded by `init.vim`) |
| `plugin-config/` | Plugin configs (named per plugin, e.g., `wiki.vim`) |
| `autoload/` | Custom autoload functions |
| `ftplugin/` | Filetype plugins |
| `colors/` | Color schemes |
| `pack/` | Vim builtin packages |
| `tools/` | Dicts, scripts, snippets |

## Key Conventions

- **Leader key**: `<space>` (not `\`)
- `:VI` - Edit vimrc
- `\ ` - Navigator key navigation
- `<Leader><Leader>m` - Menu

## Load Order

`init.vim` → `init/python.vim` → `init/essential.vim` → `init/tabsize.vim` → `init/keymaps.vim` → `init/plugins.vim` → `init/packages.vim` → etc.

## Plugin System

Uses vim-plug. Plugin configs are loaded from `plugin-config/{plugin-name}.vim` AFTER `plug#end()`.

## Python/uv

Python detection via `python#Provider()`. Sets `$pythonthreedll` on Windows GVim. Falls back to `g:python_available = v:false` if not found.

Python dependencies are managed via `uv` and declared in `pyproject.toml`.

### Setup

```bash
cd d:\WeirdData\vim-init
uv venv
uv sync
```

### Commands

- `:PyRun` or `<F5>` - Run current buffer with `uv run python`

## Testing Changes

```vim
:source ~/.vimrc
:PlugInstall
```

Or test specific file:
```vim
:source d:\WeirdData\vim-init\init.vim
```

## Important Patterns

- `g:viminit` - Points to `vim-init/` directory
- `g:plugin_config_path` - Points to `plugin-config/` directory
- Fold markers: `{{{1`, etc. (standard VimL)

## Gotchas

- `set noshellslash` required for vim-plug on Windows
- Windows path separators: use forward slashes in VimL (`/`) or double backslashes (`\\`)
- Plugin configs only load if the plugin is present in `g:plugs_order` or `s:packages`