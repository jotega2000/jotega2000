<#
.SYNOPSIS
    Enables PowerShell script block logging by configuring the required registry policy to capture detailed execution of PowerShell commands for auditing and security monitoring

.NOTES
    Author          : Julius Otega
    LinkedIn        : https://www.linkedin.com/in/julius-otega-17632913/
    GitHub          : https://github.com/jotega2000
    Date Created    : 2026-04-07
    Last Modified   : 2026-04-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000326

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000326.ps1 
#>

# Run PowerShell as Administrator

Write-Host "Remediating: WN11-CC-000326 - Enable PowerShell Script Block Logging..." -ForegroundColor Cyan

# Define registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
$name = "EnableScriptBlockLogging"
$value = 1

try {
    # Ensure the registry path exists
    if (!(Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force | Out-Null
        Write-Host "Created registry path." -ForegroundColor Yellow
    }

    # Set the registry value
    New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null

    Write-Host "Script Block Logging successfully enabled." -ForegroundColor Green
}
catch {
    Write-Host "Error applying remediation: $_" -ForegroundColor Red
}
