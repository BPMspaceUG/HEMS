# Komplettes Lab neustarten
$script_path = "C:\HEMS-Repository\Lab_Scripts" # auf MITSM_HYPERV_04

# Anzahl der angelegten VMs ermitteln
$VMs = Get-VM
$VM_count = $VMs.count - 4


Write-Output "$VM_count VMs are going to restart now."

Stop-VM kali.lab* -TurnOff -Force
Stop-VM linux.lab* -TurnOff -Force
Stop-VM windows.lab* -TurnOff -Force
Stop-VM winserver.lab* -TurnOff -Force

Start-VM kali.lab* 
Start-VM linux.lab*
Start-VM windows.lab*
Start-VM winserver.lab*

#Zurück zum Startmenü
. $script_path\Start.ps1