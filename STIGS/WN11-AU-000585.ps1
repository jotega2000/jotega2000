<#
.SYNOPSIS
  This PowerShell script remediates STIG WN11-AU-000585 by enabling failure auditing for process creation events and configuring command-line logging via the registry, then verifies both settings to ensure compliance
    
    .NOTES
    Author          : Julius Otega
    LinkedIn        : https://www.linkedin.com/in/julius-otega-17632913/
    GitHub          : https://github.com/jotega2000
    Date Created    : 2024-04-05
    Last Modified   : 2024-04-05
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000585

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000585.ps1 

#Run PowerShell as Administrator

Write-Host "Remediating: WN11-AU-000585 - Command line process auditing (Failure)..." -ForegroundColor Cyan

# --- 1. Enable Audit Process Creation (Failure) ---
try {
    auditpol /set /subcategory:"Process Creation" /failure:enable | Out-Null
    Write-Host "Audit Process Creation (Failure) enabled." -ForegroundColor Green
} catch {
    Write-Host "Failed to configure audit policy." -ForegroundColor Red
}

# --- 2. Enable command line logging ---
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit"
$name = "ProcessCreationIncludeCmdLine_Enabled"
$value = 1

# Ensure registry path exists
if (!(Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
    Write-Host "Created registry path for command line logging."
}

# Set registry value
try {
    New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWord -Force | Out-Null
    Write-Host "Command line logging enabled." -ForegroundColor Green
} catch {
    Write-Host "Failed to set registry value." -ForegroundColor Red
}

# --- 3. Verification ---
Write-Host "`nVerifying configuration..." -ForegroundColor Cyan

# Verify audit policy
$auditCheck = auditpol /get /subcategory:"Process Creation"
Write-Host $auditCheck

# Verify registry
try {
    $regCheck = Get-ItemProperty -Path $registryPath -Name $name
    if ($regCheck.$name -eq 1) {
        Write-Host "Registry setting verified: COMPLIANT" -ForegroundColor Green
    } else {
        Write-Host "Registry setting incorrect: NOT COMPLIANT" -ForegroundColor Red
    }
} catch {
    Write-Host "Registry value missing: NOT COMPLIANT" -ForegroundColor Red
}

Write-Host "`nRemediation complete." -ForegroundColor Cyan
