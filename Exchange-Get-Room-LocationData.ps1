$mailboxes = Get-EXOMailbox -RecipientTypeDetails RoomMailbox -ResultSize Unlimited

$results = foreach ($mail in $mailboxes) {
    Get-Place -Identity $mail.Identity |
    Where-Object { -not $_.City } |
    Select-Object DisplayName, Building, City, Identity
}

$results