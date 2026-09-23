if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# gsudo は引数なしで管理者シェル、引数ありでそのコマンドを現在のシェルで昇格実行する
Set-Alias -Name: "sudo" -Value: "gsudo"
Set-Alias -Name: "ls" -Value: "lsd"
function ll {
    lsd -l $args
}
function lt {
    lsd --tree $args
}
# cat は Get-Content の組み込みエイリアスのため -Force で上書き
Set-Alias -Name: "cat" -Value: "bat" -Option: AllScope -Force
Set-Alias -Name: "du" -Value: "dust"
Set-Alias -Name: "df" -Value: "duf"

# GNU 互換コマンド (uutils) を PowerShell 組み込みエイリアス・関数や System32 の同名コマンドより優先させる
$scoopShims = Join-Path ($env:SCOOP ?? "$HOME\scoop") "shims"
foreach ($cmd in "cp", "mv", "rm", "rmdir", "mkdir", "sort", "tee", "find", "timeout") {
    $exe = Join-Path $scoopShims "$cmd.exe"
    if (Test-Path $exe) {
        Set-Alias -Name: $cmd -Value: $exe -Option: AllScope -Force
    }
}

# Docker Compose
function dcu {
    docker compose up -d $args
}
function dcd {
    docker compose down $args
}

function which {
    Get-Command $args -CommandType Application -ErrorAction SilentlyContinue |
        Select-Object -First 1 -ExpandProperty Source
}

# yazi が使う file.exe を Git for Windows (公式インストーラ版 / scoop 版) から探す
if (-not $env:YAZI_FILE_ONE) {
    $git = Get-Command git -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($git) {
        $candidates = @(
            (Join-Path $git.Source "..\..\usr\bin\file.exe"),
            (Join-Path ($env:SCOOP ?? "$HOME\scoop") "apps\git\current\usr\bin\file.exe")
        )
        $file = $candidates | Where-Object { Test-Path $_ } | Select-Object -First 1
        if ($file) {
            $env:YAZI_FILE_ONE = (Resolve-Path $file).Path
        }
    }
}
function yy {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}
