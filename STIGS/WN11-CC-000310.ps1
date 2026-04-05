<#
.SYNOPSIS
    This PowerShell script ensures the required registry path exists and sets the DisableUserInstalls policy to 1, enforcing the STIG WN11-CC-000310 requirement to prevent users from changing installation options.

.NOTES
    Author          : Julius Otega
    LinkedIn        : https://www.linkedin.com/in/julius-otega-17632913/
    GitHub          : https://github.com/jotega2000
    Date Created    : 2026-04-05
    Last Modified   : 2026-04-05
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000310

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000310.ps1 
#>



# Define registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
$name = "DisableUserInstalls"
$value = 1

# Ensure the registry path exists
if (!(Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value
New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null

Write-Output "STIG WN11-CC-000310 remediated: User installs are now prohibited."
