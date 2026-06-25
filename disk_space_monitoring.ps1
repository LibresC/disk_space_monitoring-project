# Minimum free space threshold (%)
$Threshold = 15

# Get all local fixed drives
$Drives = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"

foreach ($Drive in $Drives) {
    $TotalSize = $Drive.Size
    $FreeSpace = $Drive.FreeSpace

    if ($TotalSize -gt 0) {
        $PercentFree = ($FreeSpace / $TotalSize) * 100

        Write-Host "Drive $($Drive.DeviceID)"
        Write-Host ("  Total Size : {0:N2} GB" -f ($TotalSize / 1GB))
        Write-Host ("  Free Space : {0:N2} GB" -f ($FreeSpace / 1GB))
        Write-Host ("  Free Space : {0:N2}%" -f $PercentFree)

        if ($PercentFree -lt $Threshold) {
            Write-Warning "Drive $($Drive.DeviceID) has less than $Threshold% free space!"
        }

        Write-Host ""
    }
}