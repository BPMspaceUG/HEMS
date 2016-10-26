# Shutdown Lab

$script_path = "C:\Hems-Repository\Lab_Scripts"

# Gets all necessary VMs running

$VMs = Get-VM
$VM_count = $VMs.count

Write-Output "$VM_count VMs are going to shutdown now."

Stop-VM kali.lab* -TurnOff -Force
Stop-VM linux.lab* -TurnOff -Force
stop-VM windows.lab* -TurnOff -Force
Stop-VM winserver.lab -TurnOff -Force

#Zurück zum Startmenü
. $script_path\Start.ps1