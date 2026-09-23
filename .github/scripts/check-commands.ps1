# package.yaml の scoop パッケージのコマンドが PATH 上にあり、設定が正しく読まれることを確認する
$failed = $false
function Write-Failure([string]$Message) {
    Write-Output "NG: $Message"
    $script:failed = $true
}

# パッケージ名とコマンド名が異なるものの対応表 (bucket 名は除いて引く)
# uutils は System32 や PowerShell に同名コマンドがないものを代表として確認する
$commandOf = @{
    '7zip'             = '7z'
    'ripgrep'          = 'rg'
    'neovim'           = 'nvim'
    'bottom'           = 'btm'
    'uutils-coreutils' = 'numfmt'
    'uutils-findutils' = 'xargs'
}

$packagesFile = Join-Path $PSScriptRoot '..\..\.chezmoidata\package.yaml'
$packages = yq '.packages.scoop[]' $packagesFile
if ($LASTEXITCODE -ne 0 -or -not $packages) {
    Write-Failure 'package.yaml を読み込めません'
    exit 1
}

Write-Output '## コマンドの存在確認'
foreach ($package in $packages) {
    $name = ($package -split '/')[-1]
    $cmd = $commandOf[$name] ?? $name
    $found = Get-Command $cmd -CommandType Application -ErrorAction Ignore | Select-Object -First 1
    if ($found) {
        Write-Output "OK: $cmd ($($found.Source))"
    } else {
        Write-Failure "$cmd が見つかりません"
    }
}

Write-Output '## 設定の確認'
# starship は設定の不明なキーなどを stderr に警告として出す
$warn = starship print-config 2>&1 | Where-Object { $_ -is [System.Management.Automation.ErrorRecord] }
if ($LASTEXITCODE -eq 0 -and -not $warn) {
    Write-Output 'OK: starship の設定'
} else {
    Write-Failure "starship の設定に警告があります: $warn"
}

# bat は存在しないテーマ名を指定してもエラーにならないため一覧で確認する
$theme = Get-Content (bat --config-file) -ErrorAction Ignore |
    Select-String '^--theme="(.*)"$' |
    ForEach-Object { $_.Matches[0].Groups[1].Value }
if ($theme -and (bat --list-themes --color=never) -contains $theme) {
    Write-Output "OK: bat のテーマ ($theme)"
} else {
    Write-Failure "bat のテーマ '$theme' が見つかりません"
}

# delta は存在しない feature を指定してもエラーにならないため、include した定義があるか確認する
$feature = git config --get delta.features
if ($feature -and (git config --get-regexp "^delta\.$feature\.")) {
    Write-Output "OK: delta の feature ($feature)"
} else {
    Write-Failure "delta の feature '$feature' が定義されていません"
}

if ($failed) { exit 1 }
