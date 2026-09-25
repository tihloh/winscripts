# Show standard user folders under "This PC" in Windows 11
# Restores: Desktop, Documents, Downloads, Music, Pictures, Videos
# Run as Administrator

$principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script must be run as Administrator." -ForegroundColor Red
    exit 1
}

$basePath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace"

$folders = @{
    "Desktop"   = "{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}"
    "Documents" = "{D3162B92-9365-467A-956B-92703ACA08AF}"
    "Downloads" = "{088E3905-0323-4B02-9826-5D99428E115F}"
    "Music"     = "{3DFDF296-DBEC-4FB4-81D1-6A3438BCF4DE}"
    "Pictures"  = "{24AD3AD4-A569-4530-98E1-AB02F9417AA8}"
    "Videos"    = "{F86FA3AB-70D2-4FC7-9C99-FCBF05467F3A}"
}

Write-Host "Restoring folders under This PC..." -ForegroundColor Cyan

foreach ($folder in $folders.GetEnumerator()) {
    $path = Join-Path $basePath $folder.Value

    if (!(Test-Path $path)) {
        New-Item -Path $path -Force | Out-Null
    }

    Remove-ItemProperty -Path $path -Name "HideIfEnabled" -ErrorAction SilentlyContinue
    Write-Host "  Enabled: $($folder.Key)"
}

Write-Host "Restarting File Explorer..." -ForegroundColor Yellow
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1
Start-Process explorer.exe

Write-Host "Done. Desktop, Documents, Downloads, Music, Pictures, and Videos should now appear under This PC." -ForegroundColor Green
