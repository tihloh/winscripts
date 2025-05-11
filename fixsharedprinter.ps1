# Fix-PrinterAccess.ps1
# Run this script as Administrator

Write-Host "Applying registry fixes for network printer access..." -ForegroundColor Cyan

# RPC over Named Pipes
New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows NT\Printers\RPC" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows NT\Printers\RPC" -Name "RpcUseNamedPipeProtocol" -Value 1 -Type DWord

# Point and Print Restrictions
New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Name "Restricted" -Value 0 -Type DWord
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Name "NoWarningNoElevationOnInstall" -Value 1 -Type DWord
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint" -Name "UpdatePromptSettings" -Value 0 -Type DWord

# Allow non-admin driver installs
New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\DriverInstall" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\DriverInstall" -Name "AllowNonAdminUserInstall" -Value 1 -Type DWord

# Disable RPC Authentication Level Privacy
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Print" -Name "RpcAuthnLevelPrivacyEnabled" -Value 0 -Type DWord

Write-Host "All settings applied. Please restart your computer for changes to take effect." -ForegroundColor Green
