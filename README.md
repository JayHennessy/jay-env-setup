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
| Change nvim/yazi/kitty config | Edit the file in `dot_config/` | `chezmoi apply` |

### mise tools

Edit `dot_config/mise/config.toml` to add, remove, or pin tools. The `run_onchange_after_01` script automatically re-runs `mise install -y` whenever this file changes (it hashes the file contents).

To pin a specific version, change `"latest"` to a version string:

```toml
python = "3.12"
node = "20"
```

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
