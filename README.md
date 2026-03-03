# jay-env-setup

Reproducible dev environment using [chezmoi](https://www.chezmoi.io/) + [mise](https://mise.jdx.dev/).

## One-Command Bootstrap

```bash
curl -fsSL https://raw.githubusercontent.com/JayHennessy/jay-env-setup/main/install.sh | bash
```

This installs chezmoi, clones this repo, installs all tools, and applies all configs. Supports Debian/Ubuntu, Fedora, RHEL, and Amazon Linux.

## What Gets Installed

### Via mise (23 tools)

Python, Node.js, Bun, Go, GitHub CLI, AWS CLI, Google Cloud SDK, Terraform, s5cmd, DuckDB, uv, k9s, lazygit, lazydocker, yazi, process-compose, fzf, just, bottom, jq, Neovim, zellij, tmux, zoxide, ripgrep

### Via other methods

| Tool | Method |
|------|--------|
| chezmoi | `get.chezmoi.io` |
| mise | `mise.run` |
| Docker | `get.docker.com` |
| Rust/cargo | `rustup.rs` |
| taws, stu | `cargo install` |
| gdrive | GitHub release binary |
| bpytop | `pip install` |
| tldr | `npm install -g` |
| Claude Code | `npm install -g @anthropic-ai/claude-code` |
| lazyworktree | `go install` |
| oh-my-zsh | `ohmyz.sh` install script |
| System deps | `apt`/`dnf`/`yum` (build-essential, zsh, ripgrep, fd-find, xclip) |

## Configs Included

- **Shell**: `.bashrc` and `.zshrc` with oh-my-zsh, mise activation, fzf, zoxide, aliases
- **Git**: Templated `.gitconfig`
- **Neovim**: LazyVim-based config with codediff.nvim plugin
- **Yazi**: File manager with DuckDB previews for csv/json/parquet
- **Kitty**: Terminal config

## Shell Aliases

| Alias | Command |
|-------|---------|
| `vim` | `nvim` |
| `lg` | `lazygit` |
| `ld` | `lazydocker` |
| `k` | `k9s` |
| `y` | `yazi` |
| `yy` | yazi with cd-on-exit |
| `lw` | `lazyworktree` |

## Updating

On other machines, pull and apply in one step:

```bash
chezmoi update
```

This pulls the latest changes from the repo and re-applies. If `mise/config.toml` changed, tools will be re-installed automatically.

### Making Changes

After editing any files in this repo, push and apply:

```bash
git add -A && git commit -m "description" && git push
chezmoi apply
```

### What to edit

| Change | Where to edit | Re-apply |
|--------|--------------|----------|
| Add/remove a mise tool | `dot_config/mise/config.toml` | `chezmoi apply` (auto re-runs) |
| Upgrade all mise tools to latest | Nothing — just run `mise upgrade` | No chezmoi needed |
| Add an apt package | `run_once_before_01-...` | Rename script or clear state |
| Add a cargo tool | `run_once_before_05-...` | Rename script or clear state |
| Change shell aliases | `dot_bashrc.tmpl` | `chezmoi apply` |
| Add oh-my-zsh plugins | `dot_zshrc.tmpl` (plugins list) | `chezmoi apply` |
| Change nvim/yazi/kitty config | Edit the file in `dot_config/` | `chezmoi apply` |

### mise tools

Edit `dot_config/mise/config.toml` to add, remove, or pin tools. The `run_onchange_after_01` script automatically re-runs `mise install -y` whenever this file changes (it hashes the file contents).

To pin a specific version, change `"latest"` to a version string:

```toml
python = "3.12"
node = "20"
```

### oh-my-zsh plugins

Plugins are configured in `dot_zshrc.tmpl` on the `plugins=(...)` line:

```zsh
plugins=(git extract copypath copyfile zoxide)
```

To add a plugin, append its name to the list. oh-my-zsh ships with many [built-in plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins) that just need to be listed here — no extra installation required. Some useful ones:

| Plugin | What it does |
|--------|-------------|
| `git` | Git aliases and functions |
| `extract` | `extract <file>` to unpack any archive format |
| `copypath` | `copypath` copies current directory path to clipboard |
| `copyfile` | `copyfile <file>` copies file contents to clipboard |
| `zoxide` | Smarter `cd` that learns your most-used directories |
| `docker` | Docker command completions |
| `kubectl` | Kubectl completions and aliases |
| `aws` | AWS CLI completions |
| `terraform` | Terraform aliases and completions |

For third-party plugins, clone the repo into `$ZSH_CUSTOM/plugins/` and add the name to the list. For example:

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Then add `zsh-autosuggestions` to the plugins list in `dot_zshrc.tmpl` and run `chezmoi apply`.

### apt / cargo / other tools

The `run_once_before_*` scripts only run once per machine. If you edit one and need it to re-run, either:

1. **Rename the script** (e.g. add a version suffix) — chezmoi treats it as a new script
2. **Clear chezmoi's script state**:
   ```bash
   chezmoi state delete-bucket --bucket=scriptState
   chezmoi apply
   ```

## Local Overrides

Add a `~/.bashrc.local` (or `~/.zshrc.local`) for machine-specific config — these are sourced at the end and not managed by chezmoi.
