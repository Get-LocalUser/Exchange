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
    -CountryOrRegion "United States"

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


Write-Host "Don't forget to add $PrimarySmtp to a RoomList."
Write-Host "You can use the command below to add"
Write-Host "`nAdd-DistributionGroupMember -Identity """" -Member $PrimarySmtp" -ForegroundColor Yellow