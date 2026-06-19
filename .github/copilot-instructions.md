# Copilot Instructions for Tide

Tide is a Fish shell prompt framework written entirely in Fish. It provides asynchronous rendering, a configuration wizard, and extensible prompt items.

## Build, Test, and Lint

All commands require [Fish shell](https://fishshell.com/) and are defined in the `Makefile` (which uses `SHELL := /usr/bin/env fish`).

```sh
make all          # fmt + lint + install + test
make fmt          # format all .fish files with fish_indent
make lint         # syntax-check all .fish files with fish --no-execute
make install      # install tide locally via fisher
make test         # run littlecheck test suite (installs deps, runs tests/*.test.fish)
```

To run a single test file:

```sh
make littlecheck.py
python3 littlecheck.py tests/_tide_item_node.test.fish
```

Tests use [littlecheck](https://github.com/ridiculousfish/littlecheck) with `# CHECK:` comments for expected output, and [clownfish](https://github.com/IlanCosman/clownfish) `mock` for stubbing commands.

## High-Level Architecture

```
conf.d/_tide_init.fish    — Event handlers for install/update/uninstall
functions/
  fish_prompt.fish        — Entry point; sets up async prompt rendering (1-line or 2-line)
  tide.fish               — Main CLI: tide configure | reload | bug-report
  _tide_print_item.fish   — Renders a single prompt item with separators/colors
  _tide_item_*.fish       — Individual prompt items (git, node, python, go, etc.)
  _tide_sub_*.fish        — Subcommands (configure, reload, bug-report)
  _tide_pwd.fish          — Current directory display with smart truncation
  _tide_cache_variables.fish — Caches computed values for performance
  tide/configure/         — Configuration wizard (choices, configs, fake render functions)
completions/tide.fish     — Shell completions for the tide command
tests/
  test_setup.fish         — Test harness setup (defines _tide_decolor helper)
  *.test.fish             — Littlecheck test files
```

### Key Concepts

- **Items** are prompt segments (e.g., git status, node version). Each is a function `_tide_item_<name>` in `functions/`.
- **Directory marker items** check `$_tide_parent_dirs` for project files; the Go item recognizes both `go.mod` and `go.work`.
- **Async rendering**: `fish_prompt` spawns a background Fish process to compute prompt content, then refreshes on completion.
- **Configuration wizard**: `tide configure` walks through choices in `functions/tide/configure/choices/` and applies configs from `functions/tide/configure/configs/`.

## Code Style Guidelines

### Fish Shell Conventions

- Use `test` instead of `[...]` for conditionals.
- Use `&&`/`||` instead of `and`/`or`.
  - Simple conditionals: `test -n "$foo" && echo "yes"`
  - Complex conditionals: use `if`/`else if`/`else`.
- Prefer piping over command substitution when no extra commands are needed.
- Everything in `snake_case`.

### Naming Conventions

- User-facing variables, files, and functions start with `tide_`.
- Internal (non-user-facing) names start with `_tide_`.
- Items: `_tide_item_<name>` (function) in `functions/_tide_item_<name>.fish`.
- Subcommands: `_tide_sub_<name>` (function) in `functions/_tide_sub_<name>.fish`.
- Local variables: plain `snake_case` (e.g., `set -l split_pwd`).
- Universal variables: prefixed with `tide_` (e.g., `set -U tide_right_prompt_items`).

### Formatting

- 4-space indentation for Fish files.
- 2-space indentation for JSON, Markdown, and YAML.
- Tabs for Makefile.
- UTF-8, LF line endings, trailing newline, no trailing whitespace.
- Code formatting enforced by `fish_indent`.

### Documentation

- All links in Markdown should use reference style, with references at the bottom in alphabetical order.

## Path-Specific Instructions

### `functions/_tide_item_*.fish` — Prompt Items

Each item function:
1. Checks for a trigger condition (e.g., presence of `package.json` in `$_tide_parent_dirs`).
2. Retrieves version/status info.
3. Calls `_tide_print_item <name> <icon> <content>` to render.

When creating a new item:
- Name the function `_tide_item_<name>` in `functions/_tide_item_<name>.fish`.
- Follow the pattern: guard condition → data retrieval → `_tide_print_item`.
- Add corresponding test file `tests/_tide_item_<name>.test.fish`.

### `tests/*.test.fish` — Test Files

Each test file:
1. Starts with `# RUN: %fish %s`.
2. Calls `_tide_parent_dirs` for setup.
3. Defines a helper function wrapping `_tide_decolor (_tide_item_<name>)`.
4. Uses `mock` (from clownfish) to stub external commands.
5. Creates temp directories, runs assertions with `# CHECK:` comments, and cleans up.
6. Always cleans up temp directories with `command rm -r $tmpdir`.

### `functions/tide/configure/` — Configuration Wizard

- `choices/` contains wizard step functions organized by style (all, lean, classic, rainbow, powerline).
- `configs/` contains preset configurations.
- `functions/` contains `_fake_tide_*` functions used for preview rendering during configuration.
