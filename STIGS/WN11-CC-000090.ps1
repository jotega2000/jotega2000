<#
.SYNOPSIS
    This PowerShell script remediates STIG WN11-CC-000090 by configuring the system to ensure Group Policy objects are reapplied during background processing even when no changes are detected.

.NOTES
    Author          : Julius Otega
    LinkedIn        : https://www.linkedin.com/in/julius-otega-17632913/
    GitHub          : https://github.com/jotega2000
    Date Created    : 2026-04-06
    Last Modified   : 2026-04-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000090

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000090.ps1 
#>


# Run PowerShell as Administrator

Write-Host "Remediating: WN11-CC-000090 - Force Group Policy reprocessing..." -ForegroundColor Cyan

# Define registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
$name = "DisableBkGndGroupPolicy"
$value = 0   # 0 = Disabled (allows reprocessing even if no changes)

# Ensure the registry path exists
if (!(Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value
New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null

Write-Host "Group Policy will now reprocess even if no changes are detected." -ForegroundColor Green
