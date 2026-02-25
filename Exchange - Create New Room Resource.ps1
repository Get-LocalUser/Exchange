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

$Alias = ($RoomName -replace '\s','')
$PrimarySmtp = "$Alias@example.com"

Write-Host "This may take a few minutes" -ForegroundColor Yellow

New-Mailbox `
    -Name $Alias `
    -Alias $Alias `
    -Room `
    -DisplayName $RoomName `
    -PrimarySmtpAddress $PrimarySmtp

Start-Sleep -Seconds 40

Set-Place $Alias `
    -City $City `
    -Building $Office `
    -CountryOrRegion "United States"
    -State "WA"

Set-CalendarProcessing $Alias `
    -AutomateProcessing AutoAccept `
    -BookingWindowInDays 365 `
    -AllBookInPolicy $false `
    -AllRequestInPolicy $true `
    -AllRequestOutOfPolicy $false `
    -ForwardRequestsToDelegates $true

Set-Mailbox $Alias `
    -ResourceCapacity $RoomCapacity `
    -Office $Office


$answer = Read-Host "Do you want to add $PrimarySmtp to a Room Distribution Group? 'y/n'"
if ($answer -match "^(y|yes)$") {
    $hash = @{}
    $list = Get-DistributionGroup -RecipientTypeDetails RoomList | Sort-Object Name
    foreach ($list in $list) {
        $hash[$list.Name] = $room
} 

$selectedList = $hash | Out-GridView -Title "Select a Room List" -PassThru

Add-distributionGroupMember -Identity $selectedList -Member "$PrimarySmtp"
} else {
    Exit
}