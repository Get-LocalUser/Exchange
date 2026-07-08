$rooms = Get-Mailbox -RecipientTypeDetails RoomMailbox

$action = foreach ($room in $rooms) {
    Get-CalendarProcessing -Identity $room |
        Select-Object Identity, ResourceDelegates
}

$action | Export-Csv -Path "C:\Users\hrkerko\Downloads\RoomDelegates.csv" -NoTypeInformation