param (
    [Parameter(Mandatory = $true)]
    [string]$AdminEmail,

    [Parameter(Mandatory = $true)]
    [string]$MailboxEmail,

    [Parameter(Mandatory = $true)]
    [string]$User,

    [Parameter(Mandatory = $true)]
    [string]$Permissions
)

Connect-ExchangeOnline -UserPrincipalName $AdminEmail -ShowBanner:$false -ErrorAction Stop

try {
    Add-MailboxFolderPermission -Identity "$($MailboxEmail):\calendar" -User $User -AccessRights  -ErrorAction Stop
}
catch {
    Write-Host "Failed to add permissions to $MailboxEmail for $User $($_.Exception.Message)"
}