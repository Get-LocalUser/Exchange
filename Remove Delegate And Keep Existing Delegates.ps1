$upn = Read-Host "Enter the userprincipalname"
$user = Get-MgBetaUser -Filter "userPrincipalName eq '$upn'"

$rooms = Get-Mailbox -RecipientTypeDetails RoomMailbox -ResultSize Unlimited

foreach ($room in $rooms) {
    $calprocessing = Get-CalendarProcessing -Identity $room.Identity
    $currentdelegates = $calprocessing.ResourceDelegates

    # Resolve each delegate to a recipient so we can compare against the Graph user's ObjectId
    $matcheddelegate = $currentdelegates | Where-Object {
        $delegaterecipient = Get-Recipient -Identity $_ -ErrorAction SilentlyContinue
        $delegaterecipient -and $delegaterecipient.ExternalDirectoryObjectId -eq $user.Id
    }

    if ($matcheddelegate) {
        $newdelegates = $currentdelegates | Where-Object { $_ -ne $matcheddelegate }

        Set-CalendarProcessing -Identity $room.Identity -ResourceDelegates $newdelegates -Confirm
        Write-Host "Removed $upn from $($room.Identity)"
    } else {
        Write-Host "$upn is not a delegate on $($room.Identity)"
    }
}