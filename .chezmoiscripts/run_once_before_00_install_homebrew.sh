#!/bin/bash
set -euo pipefail

# Homebrew が未インストールなら導入する (以降のパッケージインストールの前提)
for brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
    if [ -x "$brew" ]; then
        exit 0
    fi
done
if command -v brew >/dev/null 2>&1; then
    exit 0
fi

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
