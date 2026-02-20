$RoomAddress = "exmaple@example.com"

Get-DistributionGroup -RecipientTypeDetails RoomList | ForEach-Object {
    $Group = $_

    Get-DistributionGroupMember $Group.Identity -ResultSize Unlimited |
        Where-Object { $_.PrimarySmtpAddress -eq $RoomAddress } |
        Select-Object @{Name="RoomList";Expression={$Group.Name}}
}