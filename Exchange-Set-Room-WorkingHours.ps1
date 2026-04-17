$Room = Read-Host "Enter the room PrimartySMTP"
$StartTime = Read-Host "Enter the start time in 00:00:00 format. Note 24 hour time format"
$EndTime = Read-Host "Enter the end time in 00:00:00 format. Note 24 hour time format"

Set-MailboxCalendarConfiguration -Identity $Room -WorkingHoursStartTime $StartTime -WorkingHoursEndTime $EndTime