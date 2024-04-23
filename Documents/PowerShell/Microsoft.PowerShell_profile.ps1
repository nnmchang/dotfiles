function Invoke-As-Admin() {
    if ($args.count -eq 0) {
        gsudo
        return
    }
    $cmd = $args -join ' '
    gsudo "pwsh.exe -Login -Command { $cmd }"
}

Set-Alias -Name: "sudo" -Value: "Invoke-As-Admin"
Invoke-Expression (&starship init powershell)
