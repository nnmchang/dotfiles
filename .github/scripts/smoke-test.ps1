# プロファイルのエイリアス・関数・シェル統合が使えることを確認する
# プロファイルと同じスコープで dot source する: . $PROFILE; . ./.github/scripts/smoke-test.ps1
# エイリアス自体をテストするため、組み込みエイリアス (ls, cat) の使用警告は抑制する
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingCmdletAliases', '')]
param()

# dot source 先のスコープに依存しないよう、失敗は変数の再代入ではなくリストへの追加で記録する
$smokeFailures = [System.Collections.Generic.List[string]]::new()
function Invoke-Smoke([string]$Name, [scriptblock]$Test) {
    # 前のネイティブコマンドの終了コードを引き継がないようにする
    Set-Variable -Name LASTEXITCODE -Value 0 -Scope Global
    try {
        & $Test *> $null
        $ok = $LASTEXITCODE -eq 0
    } catch {
        $ok = $false
    }
    if ($ok) {
        Write-Output "OK: $Name"
    } else {
        Write-Output "NG: $Name"
        $smokeFailures.Add($Name)
    }
}

Write-Output '## エイリアス・関数'
Invoke-Smoke 'ls' { ls }
Invoke-Smoke 'll' { ll }
Invoke-Smoke 'lt' { lt --depth 1 }
Invoke-Smoke 'cat' { cat (Join-Path $HOME '.gitconfig') }
Invoke-Smoke 'du' { du -d 1 . }
Invoke-Smoke 'df' { df }
Invoke-Smoke 'sudo' { sudo --version }
Invoke-Smoke 'which' { if (-not (which git)) { throw } }
# yy は TUI を起動するため定義の有無のみ確認する
Invoke-Smoke 'yy' { Get-Command yy -CommandType Function -ErrorAction Stop }
# uutils が PowerShell 組み込みより優先されていること
Invoke-Smoke 'uutils (rm)' { if ((Get-Alias rm -ErrorAction Stop).Definition -notlike '*shims*') { throw } }

Write-Output '## シェル統合'
Invoke-Smoke 'starship' { if (-not $env:STARSHIP_SHELL) { throw } }
Invoke-Smoke 'zoxide' { Get-Command z -ErrorAction Stop }

if ($smokeFailures.Count -gt 0) { exit 1 }
