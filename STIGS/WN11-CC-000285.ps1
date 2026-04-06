.SYNOPSIS
    This PowerShell script remediates STIG WN11-CC-000285 by configuring the system to require secure RPC communication for Remote Desktop Session Host through enforcing SSL/TLS encryption via the appropriate registry setting.

.NOTES
    Author          : Julius Otega
    LinkedIn        : https://github.com/jotega2000
    GitHub          : https://www.linkedin.com/in/julius-otega-17632913/
    Date Created    : 2024-04-06
    Last Modified   : 2024-04-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000285

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000285.ps1 
#>


#Run PowerShell as Administrator

Write-Host "Remediating: WN11-CC-000285 - Require secure RPC communication for RDP..." -ForegroundColor Cyan

# Define registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$name = "SecurityLayer"
$value = 2   # 2 = SSL (TLS), required for secure RPC

# Ensure the registry path exists
if (!(Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value
New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null

Write-Host "Secure RPC (SSL/TLS) for RDP enforced successfully." -ForegroundColor Green
