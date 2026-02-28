#!/usr/bin/env bash
set -euo pipefail

if command -v rustup &>/dev/null; then
    echo "==> Rust already installed, skipping."
    exit 0
fi

echo "==> Installing Rust via rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable

echo "==> Rust installed."
