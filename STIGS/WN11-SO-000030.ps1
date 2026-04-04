<#
.SYNOPSIS
    This PowerShell script enables advanced audit policy enforcement by setting the SCENoApplyLegacyAuditPolicy registry value to 1, ensuring subcategory audit settings take precedence over legacy category-level policies. It also verifies the configuration to confirm that granular auditing is properly applied for improved security and compliance.).

.NOTES
    Author          : Julius Otega
    LinkedIn        : https://www.linkedin.com/in/julius-otega-17632913/
    GitHub          : https://github.com/jotega2000
    Date Created    : 2026-04-04
    Last Modified   : 2026-04-04
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000030

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-SO-000030.ps1 
#>



# Run PowerShell as Administrator

$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$name = "SCENoApplyLegacyAuditPolicy"
$value = 1

# Create the registry key if it doesn't exist (it usually does)
if (!(Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# Set the value
New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWord -Force

Write-Output "Audit policy subcategory override has been ENABLED."

# Verify the setting
Get-ItemProperty -Path $registryPath -Name $name
