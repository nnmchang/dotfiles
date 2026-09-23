# Build bat theme cache so that themes in ~/.config/bat/themes are available.
# テーマファイルがキャッシュより新しい場合 (external の更新時) も再ビルドする
if (Get-Command bat -ErrorAction Ignore) {
    $themesDir = Join-Path (bat --config-dir) "themes"
    $cache = Join-Path (bat --cache-dir) "themes.bin"
    $needsBuild = -not (Test-Path $cache)
    if (-not $needsBuild -and (Test-Path $themesDir)) {
        $cacheTime = (Get-Item $cache).LastWriteTime
        $needsBuild = [bool](Get-ChildItem -Path $themesDir -File -Recurse | Where-Object { $_.LastWriteTime -gt $cacheTime })
    }
    if ($needsBuild) {
        bat cache --build
    }
}
