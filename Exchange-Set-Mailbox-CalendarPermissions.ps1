param (
    [Parameter(Mandatory = $true)]
    [string]$AdminEmail = '',

    [Parameter(Mandatory = $true)]
    [string]$UserEmail,

    [Parameter(Mandatory = $true)]
    [string]$Owner,

    [Parameter(Mandatory = $true)]
    [string]$PublishingEditor
)

$RequiredModule = Get-Module -ListAvailable -Name ExchangeOnlineManagement
if (!$RequiredModule) {
        Install-Module -Name ExchangeOnlineManagement
    }
Import-Module -Name ExchangeOnlineManagement

try {
    Connect-ExchangeOnline -UserPrincipalName $AdminEmail -ShowBanner:$False -ErrorAction Stop
    Write-Host "Connected to Exchange Online successfully." -ForegroundColor Green
} catch {
    Write-Error "Failed to connect to Exchange Online: $_"
    exit 1
}

try {
    Set-MailboxFolderPermission -Identity "$($UserEmail):\calendar" -User default -AccessRights Reviewer
    Add-MailboxFolderPermission -Identity "$($UserEmail):\calendar" -User $Owner -AccessRights Owner
    Add-MailboxFolderPermission -Identity "$($UserEmail):\calendar" -User $PublishingEditor -AccessRights PublishingEditor
    Get-MailboxFolderPermission -Identity "$email`:\calendar"
}
catch {
    Write-Host "Failed to set a permission: $_"
}