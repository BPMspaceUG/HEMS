# General
$script_path = "C:\Users\Christian\OneDrive\Studium\Masterarbeit\mITSM\Git-Repository\Lab_Scripts\Manage-Core"
#$script_path = "C:\Hems-Repository\Lab_Scripts\Manage-Core"

<##Shows CPU Load
. $script_path\Get-CPULoad.ps1
Start-Sleep 2
#Shows Memory Usage
. $script_path\Get-HostMemoryUsage.ps1
start-sleep 3
#Shows PageFile Usage
. $script_path\Get-PageFileInfo.ps1
Start-Sleep 3
#>
$cpu = Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average
$cpu | Select @{Name = "CPU Load (%)";Expression = {[int]($_.Average)}}

$os = Get-Ciminstance Win32_OperatingSystem
$FreeSpaceinPercent = [math]::Round(($os.FreePhysicalMemory/$os.TotalVisibleMemorySize)*100,2)  
$os | Select @{Name = "Total RAM (GB)";Expression = {[int]($_.TotalVisibleMemorySize/1mb)}},
             @{Name = "Free RAM (GB)";Expression = {[math]::Round($_.FreePhysicalMemory/1mb,2)}},
             @{Name = "Free RAM (%)"; Expression = {$FreeSpaceinPercent}}

$pagefile = Get-WmiObject -Query "SELECT * FROM Win32_PageFileUsage"
$cpu | Select @{Name = "CPU Load (%)";Expression = {[int]($_.Average)}}
$os | Select @{Name = "Total RAM (GB)";Expression = {[int]($_.TotalVisibleMemorySize/1mb)}},
             @{Name = "Free RAM (GB)";Expression = {[math]::Round($_.FreePhysicalMemory/1mb,2)}},
             @{Name = "Free RAM (%)"; Expression = {$FreeSpaceinPercent}}
$pagefile | Select @{Name = "PageFile Size (GB)";Expression = {[float]($_.AllocatedBaseSize/1024)}},
                   @{Name = "Current Usage (GB)";Expression = {[float]($_.CurrentUsage/1024)}}