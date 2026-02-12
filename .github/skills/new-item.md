---
name: new-item
description: Guide for creating a new Tide prompt item with its test file, following repository conventions.
---

# Creating a New Tide Prompt Item

## 1. Create the Item Function

Create `functions/_tide_item_<name>.fish`:

```fish
function _tide_item_<name>
    if path is $_tide_parent_dirs/<marker_file>
        <command> --version | string match -qr "(?<v>[\d.]+)"
        _tide_print_item <name> $tide_<name>_icon' ' $v
    end
end
```

### Item Pattern

- **Guard condition**: Check for a marker file in `$_tide_parent_dirs` or check if a command exists.
- **Data retrieval**: Get version or status info, capture into variables.
- **Render**: Call `_tide_print_item <name> <args>` — the first argument must be the item name.
- **Silent on failure**: Return without output if the guard condition fails.

## 2. Create the Test File

Create `tests/_tide_item_<name>.test.fish`:

```fish
# RUN: %fish %s
_tide_parent_dirs

function _<name>
    _tide_decolor (_tide_item_<name>)
end

set -l tmpdir (mktemp -d)
cd $tmpdir

mock <command> --version "echo v1.2.3"
set -lx tide_<name>_icon ⬢

# Not in a project directory
_<name> # CHECK:

# In a project directory
touch <marker_file>
_<name> # CHECK: ⬢ 1.2.3

command rm -r $tmpdir
```

## 3. Naming Conventions

- Function: `_tide_item_<name>` (internal, so prefixed with `_tide_`)
- File: `functions/_tide_item_<name>.fish`
- Test: `tests/_tide_item_<name>.test.fish`
- Variables: `tide_<name>_icon`, `tide_<name>_color`, `tide_<name>_bg_color`

## 4. Validate

```sh
make all
```

Or test just the new item:

```sh
python3 littlecheck.py tests/_tide_item_<name>.test.fish
```
