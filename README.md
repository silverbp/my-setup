# my-setup

Personal dotfiles and shell configuration for macOS. Configs are kept here and symlinked into place so changes tracked in git take effect immediately.

## Structure

```
my-setup/
├── fish/
│   ├── config.fish    # Main fish entry point
│   ├── go.fish        # Go environment
│   ├── k8s.fish       # Kubernetes aliases
│   ├── sdlc.fish      # Git/Jira workflow helpers
│   └── system.fish    # General system aliases
└── helix/
    ├── config.toml    # Editor settings and keybindings
    └── languages.toml # LSP and language-specific config
```

## Setup

Clone the repo to `~/code/my-setup` (the fish config assumes this path by default).

```sh
git clone <repo-url> ~/code/my-setup
```

### Fish shell

Symlink the main config file:

```sh
ln -sf $HOME/code/my-setup/fish/config.fish ~/.config/fish/config.fish
```

`config.fish` automatically sources all other fish files in this repo (`go.fish`, `k8s.fish`, `sdlc.fish`, `system.fish`) and adds the repo's `bin/` to your `PATH`.

It also auto-creates `~/.config/fish/private.fish` on first run for machine-local secrets and overrides (API keys, personal `PATH` additions, etc). That file is not tracked here. The one variable it sets by default is `MY_CODE` (`$HOME/code`), which controls where the repo files are expected to live — override it there if you cloned elsewhere.

### Helix

Symlink both config files:

```sh
ln -sf $HOME/code/my-setup/helix/config.toml ~/.config/helix/config.toml
ln -sf $HOME/code/my-setup/helix/languages.toml ~/.config/helix/languages.toml
```

## What each file does

### `fish/go.fish`
- Sets `GOPATH` to `$MY_CODE/go` and creates it if missing
- Adds Go binaries to `PATH`
- Sets `GOPRIVATE` for private module access

### `fish/k8s.fish`
- `kube-cleanup-pods` — delete all non-running pods across namespaces
- `kube-diag` — drop into a `netshoot` debug pod
- `kube-win-cmd` — drop into a Windows Server Core pod
- `kube-psql` — drop into a psql pod

### `fish/sdlc.fish`
- `delete-local-branches` — delete all local branches except current
- `my-issues` — list your issues in the current Jira sprint
- `current-issue` — show your single in-progress Jira issue
- `gi` — fetch a `.gitignore` template from gitignore.io
- `sdlc-create-feature-branch` — create a `feat/<JIRA-KEY>` branch from your current in-progress issue
- `sdlc-git-branches` — list local branches with their descriptions

### `fish/system.fish`
- `whats-my-ip` — print your public IP
- `watch-ip` — continuously nmap a host/port
- `clear-dns-cache` — flush macOS DNS cache

### `helix/config.toml`
Editor preferences: relative line numbers, auto-save, clipboard-integrated yank/paste/delete, Ctrl+hjkl window navigation, inlay hints, indent guides, and tab whitespace rendering.

### `helix/languages.toml`
LSP and formatter configuration per language.
