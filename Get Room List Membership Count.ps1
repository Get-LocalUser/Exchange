Get-DistributionGroup -RecipientTypeDetails RoomList | 
ForEach-Object {
    $members = Get-DistributionGroupMember $_.Identity
    [PSCustomObject]@{
        Name = $_.DisplayName
        MemberCount = $members.Count
    }
}