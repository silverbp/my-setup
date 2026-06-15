# Navigation & Selection Tips

## The Core Mental Shift

Helix is **selection-first, action-second** — the opposite of Vim. You always select something, *then* act on it. Every motion leaves you with a selection.

---

## Navigation

| What | Helix | GoLand equiv |
|------|-------|-------------|
| Word forward/back | `w` / `b` | Ctrl+Right/Left |
| Find char on line | `f<c>` / `t<c>` | — |
| Go to definition | `gd` | Ctrl+B |
| Go to references | `gr` | Alt+F7 |
| Go to implementation | `gi` | Ctrl+Alt+B |
| Jump back / forward | `C-o` / `C-i` | Ctrl+-/+ |
| File picker | `Space+f` | Shift+Shift |
| Buffer picker | `Space+b` | — |
| Symbol in file | `Space+s` | Ctrl+F12 |
| Workspace symbols | `Space+S` | Ctrl+Alt+Shift+N |
| Grep across project | `Space+/` | Ctrl+Shift+F |
| Next/prev diagnostic | `]d` / `[d` | F2 |
| Next/prev function | `]f` / `[f` | Alt+Down/Up |

---

## Selection Expansion (Tree-Sitter)

Uses the syntax tree — far more precise than GoLand's Ctrl+W:

| What | Key | GoLand equiv |
|------|-----|-------------|
| Expand to parent node | `Alt-o` | Ctrl+W |
| Shrink to child node | `Alt-i` | Ctrl+Shift+W |
| Select previous sibling | `Alt-p` | — |
| Select next sibling | `Alt-n` | — |

Example in Go: cursor inside a function arg → `Alt-o` selects the arg → `Alt-o` selects the arg list → `Alt-o` selects the full call expression.

### Text Object Selects (faster than expanding)

| What | Key |
|------|-----|
| Inside word | `miw` |
| Inside parens / brackets / braces | `mi(` / `mi[` / `mi{` |
| Inside function | `mif` |
| Inside type / struct | `mit` |
| Inside argument | `mia` |
| Around (includes delimiters) | `ma(` / `maf` etc. |

---

## Multi-Cursor

| What | Key | GoLand equiv |
|------|-----|-------------|
| Add cursor at next occurrence | `C` | Alt+J |
| Add cursor at previous occurrence | `Alt-C` | — |
| Keep only primary cursor | `,` | Escape |
| Remove primary cursor | `Alt-,` | — |
| Split selection by regex | `s` then pattern | — |
| Split selection on newlines | `Alt-s` | — |
| Align cursors to column | `&` | — |

### Select All Occurrences (GoLand Ctrl+Alt+Shift+J)

1. Select the word: `miw`
2. Press `C` repeatedly to add cursors one by one — **or** —
3. `%` (select whole file) → `s` → type pattern → `Enter` to select all at once

---

## Refactoring

| What | Key | GoLand equiv |
|------|-----|-------------|
| Rename symbol | `Space+r` | Shift+F6 |
| Code action (extract, etc.) | `Space+a` | Alt+Enter |
| Format file | `:fmt` | Ctrl+Alt+L |

---

## Debugger (DAP via delve)

| What | Key |
|------|-----|
| Open debug menu | `Space+d` |
| Toggle breakpoint | `Space+db` |
| Continue | `Space+dc` |
| Step into | `Space+ds` |
| Step over | `Space+dn` |
| Step out | `Space+do` |

Launch templates (prompted when starting debug): `source` (debug package), `binary` (run compiled binary), `test` (debug tests), `attach` (attach to PID).

> The debug UI is minimal compared to GoLand — no watch panel yet. Use `Space+da` to add variables to the variable view when paused.
