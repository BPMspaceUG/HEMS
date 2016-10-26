$script_path = "C:\Hems-Repository\Lab_Scripts"


$os = Get-Ciminstance Win32_OperatingSystem
$FreeSpaceinPercent = [math]::Round(($os.FreePhysicalMemory/$os.TotalVisibleMemorySize)*100,2)  

$os | Select @{Name = "Total RAM (GB)";Expression = {[int]($_.TotalVisibleMemorySize/1mb)}},
             @{Name = "Free RAM (GB)";Expression = {[math]::Round($_.FreePhysicalMemory/1mb,2)}},
             @{Name = "Free RAM (%)"; Expression = {$FreeSpaceinPercent}}

Read-Host "Press Enter to continue"

#Zurück zum Startmenü
. $script_path\Start.ps1