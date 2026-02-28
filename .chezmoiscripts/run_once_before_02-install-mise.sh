#!/usr/bin/env bash
set -euo pipefail

if command -v mise &>/dev/null; then
    echo "==> mise already installed, skipping."
    exit 0
fi

echo "==> Installing mise..."
curl -fsSL https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"

echo "==> mise installed: $(mise --version)"
