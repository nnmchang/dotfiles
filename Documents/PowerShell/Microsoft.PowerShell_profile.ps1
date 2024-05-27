Invoke-Expression (&starship init powershell)
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

$env:YAZI_FILE_ONE=$(join-path $(where.exe git) ../../usr/bin/file.exe)
function yy {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}
