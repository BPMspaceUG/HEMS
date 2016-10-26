# Komplettes Lab neustarten
$script_path = "C:\HEMS-Repository\Lab_Scripts" # auf MITSM_HYPERV_04

# Anzahl der angelegten VMs ermitteln
$VMs = Get-VM -name winserver.lab*
$VM_count = $VMs.count


Write-Output "$VM_count VMs are going to restart now."

Stop-VM winserver.lab* -TurnOff -Force

Start-VM winserver.lab* 


#Zurück zum Startmenü
. $script_path\Start.ps1