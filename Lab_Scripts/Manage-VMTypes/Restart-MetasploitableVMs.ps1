# Komplettes Lab neustarten
$script_path = "C:\HEMS-Repository\Lab_Scripts" # auf MITSM_HYPERV_04

# Anzahl der angelegten VMs ermitteln
$VMs = Get-VM -name linux.lab*
$VM_count = $VMs.count


Write-Output "$VM_count VMs are going to restart now."

Stop-VM linux.lab* -TurnOff -Force

Start-VM linux.lab* 


#Zurück zum Startmenü
. $script_path\Start.ps1