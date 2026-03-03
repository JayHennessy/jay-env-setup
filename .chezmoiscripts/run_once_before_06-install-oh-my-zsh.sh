#!/usr/bin/env bash
set -euo pipefail

if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "==> oh-my-zsh already installed, skipping."
    exit 0
fi

echo "==> Installing oh-my-zsh..."
RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "==> oh-my-zsh installed."
