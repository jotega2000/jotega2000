<#
.SYNOPSIS
    This PowerShell script remediates STIG WN11-CC-000110 by ensuring the registry policy is configured to disable HTTP printing, preventing printers from being accessed over HTTP in compliance with security requirements.

.NOTES
    Author          : Julius Otega
    LinkedIn        : https://www.linkedin.com/in/julius-otega-17632913/
    GitHub          : https://github.com/jotega2000
    Date Created    : 2024-04-06
    Last Modified   : 2024-04-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000110

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000110.ps1 
#>


# Run PowerShell as Administrator

Write-Host "Remediating: WN11-CC-000110 - Disable Printing over HTTP..." -ForegroundColor Cyan

# Define registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$name = "DisableHTTPPrinting"
$value = 1

try {
    # Ensure the registry path exists
    if (!(Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force | Out-Null
        Write-Host "Created registry path." -ForegroundColor Yellow
    }

    # Set the registry value
    New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null

    Write-Host "Printing over HTTP has been disabled successfully." -ForegroundColor Green
}
catch {
    Write-Host "Failed to apply remediation: $_" -ForegroundColor Red
}
