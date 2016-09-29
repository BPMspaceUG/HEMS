Function Get-PageFileInfo
{

    $pagefile = Get-WmiObject -Query "SELECT * FROM Win32_PageFileUsage"
    $pagefile | Select @{Name = "PageFile Size (GB)";Expression = {[float]($_.AllocatedBaseSize/1024)}},
                       @{Name = "Current Usage (GB)";Expression = {[float]($_.CurrentUsage/1024)}}

}