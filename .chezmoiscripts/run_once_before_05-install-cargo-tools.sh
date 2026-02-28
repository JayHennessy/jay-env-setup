#!/usr/bin/env bash
set -euo pipefail

# Source cargo env
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

if ! command -v cargo &>/dev/null; then
    echo "==> cargo not found, skipping cargo tools."
    exit 0
fi

echo "==> Installing cargo tools..."

# taws - AWS TUI
if ! command -v taws &>/dev/null; then
    echo "    Installing taws..."
    cargo install taws
fi

# stu - S3 TUI
if ! command -v stu &>/dev/null; then
    echo "    Installing stu..."
    cargo install --locked stu
fi

# gdrive - Google Drive CLI (download binary)
if ! command -v gdrive &>/dev/null; then
    echo "    Installing gdrive..."
    mkdir -p "$HOME/.local/bin"
    GDRIVE_VERSION=$(curl -fsSL https://api.github.com/repos/glotlabs/gdrive/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
    curl -fsSL "https://github.com/glotlabs/gdrive/releases/download/${GDRIVE_VERSION}/gdrive_linux-x64.tar.gz" | tar xz -C "$HOME/.local/bin" gdrive
    chmod +x "$HOME/.local/bin/gdrive"
fi

echo "==> Cargo tools installed."
