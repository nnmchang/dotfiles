#!/bin/bash
# package.yaml の brew パッケージのコマンドが PATH 上にあり、設定が正しく読まれることを確認する
# ログインシェルの PATH で実行する: "$SHELL" -lic .github/scripts/check-commands.sh
set -uo pipefail

failed=0
fail() {
    echo "NG: $*" >&2
    failed=1
}

# パッケージ名とコマンド名が異なるものの対応表
command_of() {
    case "$1" in
        ripgrep) echo rg ;;
        neovim) echo nvim ;;
        git-delta) echo delta ;;
        bottom) echo btm ;;
        *) echo "$1" ;;
    esac
}

packages_file="$(dirname "$0")/../../.chezmoidata/package.yaml"
packages="$(yq '.packages.brew[]' "$packages_file")" || {
    fail "package.yaml を読み込めません"
    exit 1
}

echo "## コマンドの存在確認"
# 各パッケージのコマンドに加えて chezmoi スクリプトが導入するもの (rustup) も確認する
for cmd in $(for p in $packages; do command_of "$p"; done) rustup cargo rust-analyzer; do
    if path="$(command -v "$cmd")"; then
        echo "OK: $cmd ($path)"
    else
        fail "$cmd が見つかりません"
    fi
done

echo "## 設定の確認"
# starship は設定の不明なキーなどを stderr に警告として出す
if warn="$(starship print-config 2>&1 >/dev/null)" && [ -z "$warn" ]; then
    echo "OK: starship の設定"
else
    fail "starship の設定に警告があります: $warn"
fi

# bat は存在しないテーマ名を指定してもエラーにならないため一覧で確認する
theme="$(sed -n 's/^--theme="\(.*\)"$/\1/p' "$(bat --config-file)")"
if [ -n "$theme" ] && bat --list-themes --color=never | grep -qxF "$theme"; then
    echo "OK: bat のテーマ ($theme)"
else
    fail "bat のテーマ '$theme' が見つかりません"
fi

# delta は存在しない feature を指定してもエラーにならないため、include した定義があるか確認する
feature="$(git config --get delta.features)"
if [ -n "$feature" ] && git config --get-regexp "^delta\\.$feature\\." >/dev/null; then
    echo "OK: delta の feature ($feature)"
else
    fail "delta の feature '$feature' が定義されていません"
fi

exit "$failed"
