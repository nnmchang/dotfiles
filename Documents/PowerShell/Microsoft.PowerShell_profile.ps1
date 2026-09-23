if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}
Invoke-Expression (& { (zoxide init powershell | Out-String) })

function Invoke-As-Admin() {
    if ($args.count -eq 0) {
        gsudo
        return
    }
    $cmd = $args -join ' '
    gsudo "pwsh.exe -Login -Command { $cmd }"
}

Set-Alias -Name: "sudo" -Value: "Invoke-As-Admin"
Set-Alias -Name: "ls" -Value: "lsd"
function ll {
    ls -l $args
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

$env:YAZI_FILE_ONE=$(join-path $(where.exe git | Select-Object -First 1) ../../usr/bin/file.exe)
function yy {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}
