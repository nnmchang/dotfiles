#!/bin/bash
set -euo pipefail

if ! command -v rustup >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile default
    # shellcheck source=/dev/null
    . "$HOME/.cargo/env"
fi

# rustup のみ導入済みでツールチェーンが無い場合 (brew の rustup など) に備える
if ! rustup default >/dev/null 2>&1; then
    rustup default stable
fi

rustup component add rust-analyzer
