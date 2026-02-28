#!/usr/bin/env bash
set -euo pipefail

echo "==> Jay's Dev Environment Bootstrap"
echo ""

# Install chezmoi if not present
if ! command -v chezmoi &>/dev/null; then
    echo "==> Installing chezmoi..."
    sh -c "$(curl -fsSL https://get.chezmoi.io)" -- -b "$HOME/.local/bin"
    export PATH="$HOME/.local/bin:$PATH"
fi

# Init and apply dotfiles
echo "==> Initializing dotfiles with chezmoi..."
chezmoi init --apply JayHennessy/jay-env-setup

echo ""
echo "==> Bootstrap complete! Open a new terminal to pick up all changes."
