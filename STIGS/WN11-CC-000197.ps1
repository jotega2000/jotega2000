<#
.SYNOPSIS
    This PowerShell script remediates STIG WN11-CC-000197 by creating the required registry path and setting DisableWindowsConsumerFeatures to 1, thereby disabling Microsoft consumer experiences to prevent unwanted app installations, reduce network traffic, and enhance overall system security and compliance.

.NOTES
    Author          : Julius Otega
    LinkedIn        : https://www.linkedin.com/in/julius-otega-17632913/
    GitHub          : https://github.com/jotega2000
    Date Created    : 2026-04-08
    Last Modified   : 2026-04-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000197

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000197
#>


.DESCRIPTION
    This script ensures the "DisableWindowsConsumerFeatures" policy is enabled
    by setting the appropriate registry key.

.NOTES
    Requires administrative privileges.
#>

Write-Host "Remediating: WN11-CC-000197 - Disable Microsoft consumer experiences..." -ForegroundColor Cyan

# Define registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
$valueName = "DisableWindowsConsumerFeatures"
$valueData = 1

try {
    # Ensure the registry path exists
    if (!(Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force | Out-Null
        Write-Host "Created registry path: $registryPath" -ForegroundColor Yellow
    }

    # Set the registry value
    New-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -PropertyType DWord -Force | Out-Null

    Write-Host "Microsoft consumer experiences have been disabled." -ForegroundColor Green
}
catch {
    Write-Host "Error applying remediation: $_" -ForegroundColor Red
}
