
<#
.SYNOPSIS
   Renaming the built-in Guest account reduces the risk of unauthorized access by obscuring a well-known account name commonly targeted by attackers, thereby strengthening system security and supporting compliance with STIG requirements.

.NOTES
    Author          : Julius Otega
    LinkedIn        : https://www.linkedin.com/in/julius-otega-17632913/
    GitHub          : https://github.com/jotega2000
    Date Created    : 2026-04-08
    Last Modified   : 2026-04-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000025

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000025.ps1 
#>



.DESCRIPTION
    This script identifies the built-in Guest account (RID -501) and renames it
    to a specified non-default name to reduce the risk of unauthorized access.

.NOTES
    Run PowerShell as Administrator.
#>

Write-Host "Remediating: WN11-SO-000025 - Rename built-in Guest account..." -ForegroundColor Cyan

# --- Define new Guest account name ---
$NewGuestName = "DisabledGuestAcct"   # Change this if desired

try {
    # Get the Guest account using SID ending in -501
    $GuestAccount = Get-LocalUser | Where-Object {
        $_.SID.Value -like "*-501"
    }

    if ($null -eq $GuestAccount) {
        Write-Host "Guest account not found." -ForegroundColor Yellow
        return
    }

    # Check if already renamed
    if ($GuestAccount.Name -eq $NewGuestName) {
        Write-Host "Guest account is already renamed to '$NewGuestName'." -ForegroundColor Green
    }
    else {
        # Rename the account
        Rename-LocalUser -Name $GuestAccount.Name -NewName $NewGuestName
        Write-Host "Guest account successfully renamed to '$NewGuestName'." -ForegroundColor Green
    }
}
catch {
    Write-Host "Error occurred while renaming Guest account: $_" -ForegroundColor Red
}
