<#
.SYNOPSIS
    This PowerShell script ensures the required registry paths for Windows Installer policies exist in both the system and user hives, then sets the AlwaysInstallElevated value to 0 to disable elevated installation privileges. This enforces compliance with STIG WN11-CC-000315 by preventing unauthorized privilege escalation through Windows Installer.

.NOTES
    Author          : Julius Otega
    LinkedIn        : https://www.linkedin.com/in/julius-otega-17632913/
    GitHub          : https://github.com/jotega2000
    Date Created    : 2026-04-05
    Last Modified   : 2026-04-05
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000315

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000315.ps1 
#>

# Define registry paths
$machinePath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
$userPath = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer"

# Ensure the registry paths exist
if (!(Test-Path $machinePath)) {
    New-Item -Path $machinePath -Force | Out-Null
}

if (!(Test-Path $userPath)) {
    New-Item -Path $userPath -Force | Out-Null
}

# Set AlwaysInstallElevated to 0 (Disabled)
New-ItemProperty -Path $machinePath -Name "AlwaysInstallElevated" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path $userPath -Name "AlwaysInstallElevated" -Value 0 -PropertyType DWord -Force

Write-Output "STIG WN11-CC-000315 remediated: AlwaysInstallElevated is disabled."
