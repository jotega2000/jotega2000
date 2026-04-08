<#
.SYNOPSIS
    This PowerShell script enforces the STIG requirement by disabling the indexing of encrypted files through setting the appropriate Windows Search policy registry value.

.NOTES
    Author          : Julius Otega
    LinkedIn        : https://www.linkedin.com/in/julius-otega-17632913/
    GitHub          : https://github.com/jotega2000
    Date Created    : 2026-04-07
    Last Modified   : 2026-04-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000305

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000305.ps1 
#>

# Run PowerShell as Administrator

Write-Host "Remediating: Disable indexing of encrypted files..." -ForegroundColor Cyan

# Define registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
$name = "AllowIndexingEncryptedStoresOrItems"
$value = 0

# Ensure the registry path exists
if (!(Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
    Write-Host "Registry path created." -ForegroundColor Yellow
}

# Set the registry value
New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWord -Force | Out-Null

Write-Host "Indexing of encrypted files has been DISABLED." -ForegroundColor Green
