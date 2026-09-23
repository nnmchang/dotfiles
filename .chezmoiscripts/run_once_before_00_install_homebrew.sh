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

# 端末があればインストーラが sudo のパスワードを尋ねられるよう対話モードで実行する
if [ -t 0 ]; then
    noninteractive=""
else
    noninteractive=1
fi

# sudo が使えない環境などで失敗しても dotfiles の適用自体は継続する
if ! NONINTERACTIVE="$noninteractive" /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
    echo "warning: Homebrew のインストールに失敗しました。パッケージのインストールはスキップされます" >&2
fi
