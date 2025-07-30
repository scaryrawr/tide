# AGENTS.md

## Build, Lint, and Test Commands

- **Run all tests:** `make test`
- **Run a single test:** `fish tests/<test_file>.fish` (e.g., `fish tests/_tide_item_git.test.fish`)
- **Lint (Fish syntax):** `fish --no-execute <file>.fish` or use `fish_actions/syntax-check@v1` (see CI)
- **Format:** Use `fish_indent -w <file>.fish` or `fish_actions/format-check@v1`
- **Mega-Linter:** Run via CI or locally with `.mega-linter.yml` config

## Code Style Guidelines

- **Indentation:** 4 spaces (see `.editorconfig`), tabs for Makefiles
- **Line endings:** LF, UTF-8 encoding
- **Imports:** Use `source` for including other scripts; keep imports at the top
- **Naming:** Use snake_case for functions and variables; prefix private/internal functions with `_`
- **Functions:** Use `function ... end` blocks; add `--description` for public functions
- **Error handling:** Always check exit status of commands; prefer `if test ...` over Bash-isms
- **Quoting:** Quote all variable expansions unless splitting is intended
- **Trailing whitespace:** None (auto-trimmed)
- **Final newline:** Required
- **Test conventions:** Use assertions in test scripts; see [Fish Shell: Writing tests](https://shinyu.org/en/fish-shell/testing-and-debugging/writing-tests/)
- **Linting:** Use `fish_indent`, `fish --no-execute`, and optionally [fish-lsp](https://github.com/ndonfris/fish-lsp) or [fishcheck](https://github.com/mattmc3/fishcheck) for advanced linting

> For more, see `.editorconfig`, `.mega-linter.yml`, and `.github/workflows/CI.yml`.
