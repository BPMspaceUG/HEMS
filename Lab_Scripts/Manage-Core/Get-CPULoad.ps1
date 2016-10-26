$script_path = "C:\Hems-Repository\Lab_Scripts"

# Disburses the current CPU Load

$cpu = Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average

$cpu | Select @{Name = "CPU Load (%)";Expression = {[int]($_.Average)}}


Read-Host "Press Enter to continue"

#Zurück zum Startmenü
. $script_path\Start.ps1
