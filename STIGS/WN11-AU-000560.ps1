<#
.SYNOPSIS
   This PowerShell script remediates STIG **WN11-AU-000560** by enabling Success auditing for “Other Logon/Logoff Events,” ensuring Windows 11 properly logs relevant authentication activities in compliance with security auditing requirements.

.NOTES
    Author          : Julius Otega
    LinkedIn        : https://www.linkedin.com/in/julius-otega-17632913/
    GitHub          : https://github.com/jotega2000
    Date Created    : 2026-04-06
    Last Modified   : 2026-04-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000560

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-AU-000560.ps1 


.NOTES
    Must be run with administrative privileges.
#>

Write-Host "Remediating: WN11-AU-000560 - Audit Other Logon/Logoff Events (Success)..." -ForegroundColor Cyan

try {
    # Enable success auditing for "Other Logon/Logoff Events"
    auditpol /set /subcategory:"Other Logon/Logoff Events" /success:enable | Out-Null

    Write-Host "SUCCESS: 'Other Logon/Logoff Events' auditing (Success) is now enabled." -ForegroundColor Green
}
catch {
    Write-Host "ERROR: Failed to configure audit policy." -ForegroundColor Red
    Write-Host $_.Exception.Message
}

# --- Verification ---
Write-Host "`nVerifying configuration..." -ForegroundColor Yellow
$auditResult = auditpol /get /subcategory:"Other Logon/Logoff Events"

if ($auditResult -match "Success\s+Enabled") {
    Write-Host "VERIFIED: Setting is correctly configured." -ForegroundColor Green
} else {
    Write-Host "WARNING: Setting may not be properly configured." -ForegroundColor Red
}
