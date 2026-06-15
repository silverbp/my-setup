# Helix

Migration reference from JetBrains GoLand. Covers Go and Terraform development.

## Guides

- [Navigation & Selection Tips](navigation-and-selection-tips.md) — moving around, tree-sitter selection expansion, multi-cursor, debugger shortcuts

## Config Files

- `config.toml` — editor settings, keybindings
- `languages.toml` — LSP and DAP configuration for Go, Terraform/HCL, TOML, YAML

## Language Servers

| Language | Server |
|----------|--------|
| Go | `gopls`, `golangci-lint-langserver` |
| Terraform / HCL | `terraform-ls`, `efm-langserver` |

## Command Line Expansions

Available in keybindings and typed commands via `%{variable}` syntax (requires Helix with PR #12527):

| Variable | Description |
|----------|-------------|
| `%{buffer_name}` | Current file path |
| `%{cursor_line}` | Current line number |
| `%{cursor_column}` | Current column number |
| `%{selection_line_start}` | First line of selection |
| `%{selection_line_end}` | Last line of selection |
| `%sh{...}` | Inline shell command output |

Escape a literal `%` with `%%`.

## Debugger

Go debugging uses [delve](https://github.com/go-delve/delve) via DAP. Make sure `dlv` is on your PATH:

```sh
go install github.com/go-delve/delve/cmd/dlv@latest
```
