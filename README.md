# jay-env-setup

Reproducible dev environment using [chezmoi](https://www.chezmoi.io/) + [mise](https://mise.jdx.dev/).

## One-Command Bootstrap

```bash
curl -fsSL https://raw.githubusercontent.com/JayHennessy/jay-env-setup/main/install.sh | bash
```

This installs chezmoi, clones this repo, prompts for git name/email/GitHub username, then installs all tools and applies all configs.

## What Gets Installed

### Via mise (21 tools)

Python, Node.js, Bun, Go, GitHub CLI, AWS CLI, Google Cloud SDK, Terraform, s5cmd, DuckDB, uv, k9s, lazygit, lazydocker, yazi, process-compose, fzf, just, bottom, jq, Neovim

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
| System deps | `apt` (build-essential, zsh, ripgrep, fd-find, xclip) |

## Configs Included

- **Shell**: `.bashrc` and `.zshrc` with mise activation, fzf integration, aliases
- **Git**: Templated `.gitconfig` with prompted identity
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

## Updating

```bash
chezmoi update
```

This pulls the latest changes from the repo and re-applies. If `mise/config.toml` changed, tools will be re-installed automatically.

## Local Overrides

Add a `~/.bashrc.local` (or `~/.zshrc.local`) for machine-specific config — these are sourced at the end and not managed by chezmoi.
