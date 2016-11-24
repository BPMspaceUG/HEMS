# Komplettes Lab starten

$script_path = "C:\Hems-Repository\Lab_Scripts"


$VMs = Get-VM "*-lab*"
$VM_count = $VMs.count

Write-Output "$VM_count VMs are going to start now."
Start-VM "*-lab*"

#Zurück zum Startmenü
. $script_path\Start.ps1