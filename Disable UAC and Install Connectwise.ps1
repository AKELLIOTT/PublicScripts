Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLUA' -Value '0'
Get-MpPreference | Format-Table PUAProtection
Set-MpPreference -PUAProtection Disabled

Reboot 
Install Connectwise 

Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLUA' -Value '1'
Set-MpPreference -PUAProtection Enabled
Get-MpPreference | Format-Table PUAProtection