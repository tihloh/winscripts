# Enable Insecure Guest Logons in Windows 11 for SMB access

# Define the registry path and value
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"
$valueName = "AllowInsecureGuestAuth"
$valueData = 1

# Check if key exists, create if missing
if (!(Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
New-ItemProperty -Path $regPath -Name $valueName -Value $valueData -PropertyType DWORD -Force | Out-Null

Write-Host "Guest access has been enabled for SMB. Restarting the Workstation service..."

# Restart the Workstation service to apply changes
Restart-Service -Name "LanmanWorkstation" -Force

Write-Host "Done. You may now try connecting to the shared folder again."
