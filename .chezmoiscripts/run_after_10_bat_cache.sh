#!/bin/bash
set -euo pipefail

# Build bat theme cache so that themes in ~/.config/bat/themes are available.
# テーマファイルがキャッシュより新しい場合 (external の更新時) も再ビルドする
if command -v bat >/dev/null 2>&1; then
    themes_dir="$(bat --config-dir)/themes"
    cache="$(bat --cache-dir)/themes.bin"
    if [ ! -f "$cache" ] || [ -n "$(find "$themes_dir" -newer "$cache" -type f 2>/dev/null)" ]; then
        bat cache --build
    fi
fi
