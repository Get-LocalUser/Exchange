$boxes = Get-Mailbox -RecipientTypeDetails RoomMailbox | ForEach-Object {
    $place = Get-Place -Identity $_
    [PSCustomObject]@{
        Identity = $_.Identity
        City     = $place.City
    }
}

$boxes