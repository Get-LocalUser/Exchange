param(
    [Parameter(Mandatory = $true)]
    [int]$RoomCapacity,

    [Parameter(Mandatory = $true)]
    [string]$RoomName,

    [Parameter(Mandatory = $true)]
    [string]$City,

    [Parameter(Mandatory = $true)]
    [string]$Office
)

$Alias = $RoomName -replace '[^A-Za-z0-9]', ''
$PrimarySmtp = "$Alias@example.com"

Write-Host "Creating room mailbox, this may take a few minutes..." -ForegroundColor Yellow

New-Mailbox `
    -Name $RoomName `
    -Alias $Alias `
    -Room `
    -DisplayName $RoomName `
    -PrimarySmtpAddress $PrimarySmtp

Start-Sleep -Seconds 40

Set-Mailbox $Alias `
    -ResourceCapacity $RoomCapacity `
    -Office $Office

Set-Place $Alias `
    -City $City `
    -Building $Office `
    -CountryOrRegion "United States" `
    -State "WA"

Set-CalendarProcessing $Alias `
    -AutomateProcessing AutoAccept `
    -BookingWindowInDays 365 `
    -AllBookInPolicy $true `
    -AllRequestInPolicy $true `
    -AllRequestOutOfPolicy $false `
    -ForwardRequestsToDelegates $true

Write-Host ""
Write-Host "Room mailbox created:" -ForegroundColor Green
Write-Host "  Name : $RoomName"
Write-Host "  Email: $PrimarySmtp"
Write-Host ""

$answer = Read-Host "Do you want to add $PrimarySmtp to a Room List? (y/n)"

if ($answer -match '^(y|yes)$') {

    Write-Host ""
    Write-Host "Available Room Lists:" -ForegroundColor Cyan

    Get-DistributionGroup -RecipientTypeDetails RoomList |
        Sort-Object Name | 
        Select-Object Name, PrimarySmtpAddress | 
        Format-Table

    Write-Host ""

    $RoomList = Read-Host "Enter the Room List name or email address"

    Add-DistributionGroupMember `
        -Identity $RoomList `
        -Member $PrimarySmtp

    Write-Host "$PrimarySmtp added to $RoomList" -ForegroundColor Green
}

Write-Host "Complete." -ForegroundColor Green