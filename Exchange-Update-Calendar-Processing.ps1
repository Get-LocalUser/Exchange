$Rooms = @()

foreach ($Room in $Rooms) {
    Set-CalendarProcessing -Identity $Room `
        -AutomateProcessing AutoAccept `
        -AllBookInPolicy $false `
        -AllRequestInPolicy $true `
        -AllRequestOutOfPolicy $false `
        -ForwardRequestsToDelegates $true
}