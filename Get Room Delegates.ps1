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
        }
    }
}

<<<<<<< Updated upstream
$action | Export-Csv -Path "C:\Users\Admin\Downloads\shared\RoomDelegates.csv" -NoTypeInformation 
=======
$action | Export-Csv -Path "C:\Users\hrkerko\Downloads\RoomDelegates.csv" -NoTypeInformation -Append
>>>>>>> Stashed changes
