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
make littlecheck.py
fish -c 'type -q mock || fisher install IlanCosman/clownfish'
python3 littlecheck.py tests/_tide_item_<name>.test.fish
```

Single-file tests use Fish's function path, so run `make install` first when possible. If local Fish config conflicts prevent installing, run littlecheck with a `%fish` substitution that starts Fish with the checkout's `functions/` directory first in `fish_function_path`.
