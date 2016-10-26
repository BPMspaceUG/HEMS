$script_path = "C:\Hems-Repository\Lab_Scripts"

    $pagefile = Get-WmiObject -Query "SELECT * FROM Win32_PageFileUsage"
    $pagefile | Select @{Name = "PageFile Size (GB)";Expression = {[float]($_.AllocatedBaseSize/1024)}},
                       @{Name = "Current Usage (GB)";Expression = {[float]($_.CurrentUsage/1024)}}


Read-Host "Press Enter to continue"

#Zurück zum Startmenü
. $script_path\Start.ps1