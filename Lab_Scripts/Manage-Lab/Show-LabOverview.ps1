#Laborübersicht anzeigen

$script_path = "C:\HEMS-Repository\Lab_Scripts" # auf MITSM_HYPERV_04

# Anzahl der angelegten VMs ermitteln

$VMs = Get-VM
$VM_count = $VMs.count - 4


Write-Output "Im Moment sind $VM_count virtuelle Maschinen angelegt"

get-vm | select Name, State, CPUUsage, MemoryAssigned, Uptime | format-table 

Read-Host "Dücken Sie Enter um zum Menü zurückzukehren"

#Zurück zum Startmenü
. $script_path\Start.ps1