#!/bin/bash
set -euo pipefail

if ! command -v rustup >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile default
    # shellcheck source=/dev/null
    . "$HOME/.cargo/env"
fi

rustup component add rust-analyzer
