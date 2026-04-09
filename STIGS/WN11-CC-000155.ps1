<#
.SYNOPSIS
    This PowerShell script enforces STIG WN11-CC-000155 by disabling Solicited Remote Assistance through a registry setting, ensuring users cannot invite remote connections and thereby reducing the risk of unauthorized system access and potential security compromise.

.NOTES
    Author          : Julius Otega
    LinkedIn        : https://www.linkedin.com/in/julius-otega-17632913/
    GitHub          : https://github.com/jotega2000
    Date Created    : 2026-04-09
    Last Modified   : 2026-04-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000155

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000155.ps1 
#>



# Run PowerShell as Administrator

Write-Host "Remediating: WN11-CC-000155 - Disable Solicited Remote Assistance..." -ForegroundColor Cyan

# Define registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$name = "fAllowToGetHelp"
$value = 0

try {
    # Ensure the registry path exists
    if (!(Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force | Out-Null
        Write-Host "Registry path created." -ForegroundColor Yellow
    }

    # Set the policy value to disable Solicited Remote Assistance
    New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null

    Write-Host "Solicited Remote Assistance has been successfully disabled." -ForegroundColor Green
}
catch {
    Write-Host "Error applying remediation: $_" -ForegroundColor Red
}

# Verify the setting
$currentValue = Get-ItemProperty -Path $registryPath -Name $name -ErrorAction SilentlyContinue

if ($currentValue.$name -eq 0) {
    Write-Host "Verification Passed: Solicited Remote Assistance is disabled." -ForegroundColor Green
} else {
    Write-Host "Verification Failed: Setting is not compliant." -ForegroundColor Red
}
