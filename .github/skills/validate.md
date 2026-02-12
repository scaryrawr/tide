---
name: validate
description: Run formatting, linting, and tests for the Tide repository. Use after making code changes to ensure nothing is broken.
---

# Validation Skill

Run the full validation pipeline for Tide. Requires Fish shell.

## Steps

1. **Format** all Fish files:
   ```sh
   make fmt
   ```

2. **Lint** all Fish files (syntax check):
   ```sh
   make lint
   ```

3. **Install** the current version locally:
   ```sh
   make install
   ```

4. **Test** with littlecheck:
   ```sh
   make test
   ```

Or run everything at once:
```sh
make all
```

## Single File Test

To test a single item after changes:
```sh
python3 littlecheck.py tests/_tide_item_<name>.test.fish
```
