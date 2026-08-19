$rooms = Get-Mailbox -RecipientTypeDetails RoomMailbox

$action = foreach ($room in $rooms) {
    $calProcessing = Get-CalendarProcessing -Identity $room.Name
    $currentdelegates = $calProcessing.ResourceDelegates

    foreach ($delegate in $currentdelegates) {
        $delegaterecipient = Get-Recipient -Identity $delegate

        [PSCustomObject]@{
            Room                = $room.DisplayName
            RoomSmtpAddress     = $room.PrimarySmtpAddress
            Delegate            = $delegateRecipient.DisplayName
            DelegateSmtpAddress = $delegateRecipient.PrimarySmtpAddress
            DelegateObjectID    = $delegaterecipient.ExternalDirectoryObjectId
        }
    }
}

$action | Export-Csv -Path "$ENV:USERPROFILE\Downloads\RoomDelegates.csv" -NoTypeInformation 