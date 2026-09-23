# shellcheck shell=bash
# 対話シェルでエイリアス・関数・シェル統合が使えることを確認する (bash / zsh 共通)
# エイリアスを展開させるため対話シェル内で source する: "$SHELL" -lic 'source .github/scripts/smoke-test.sh'

smoke_failed=0
smoke_run() {
    if eval "$1" >/dev/null 2>&1; then
        echo "OK: $1"
    else
        echo "NG: $1" >&2
        smoke_failed=1
    fi
}

echo "## エイリアス"
# eval で実行することでエイリアスが展開される
smoke_run 'ls'
smoke_run 'll'
smoke_run 'la'
smoke_run 'l'
smoke_run 'lt --depth 1'
smoke_run 'cat "$HOME/.gitconfig"'
smoke_run 'du -d 1 .'
smoke_run 'df'

echo "## 関数・シェル統合"
# yy は TUI を起動するため定義の有無のみ確認する
smoke_run 'type yy'
# sheldon 経由で読み込まれる init が実行されていること
smoke_run '[ -n "${STARSHIP_SHELL:-}" ]'
smoke_run 'type z'
smoke_run 'type mise'
smoke_run 'z "$HOME"'

exit "$smoke_failed"
