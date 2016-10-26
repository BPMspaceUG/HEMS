param (
[string]$participant_number
)

# Deletes the complete Lab
$script_path = "C:\Hems-Repository\Lab_Scripts" # on MITSM_HYPERV_04

# Gets the number of all VMs

if (!$participant_number) { # Test, ob bereits ein Wert für TN_Nr übergeben wurde 
$participant_number = [convert]::ToInt32((Read-Host "Für welchen Teilnehmer soll die Umgebung gelöscht werden?"), 10)
$participant_number = "{0:00}" -f $participant_number
}

$VM_Name="kali.lab$participant_number.net"


Write-Output "Es werden nun $VM_count VMs gelöscht."

Write-Output "Kali VMs are now shuting down"
Stop-VM $VM_Name -TurnOff -force -ErrorAction SilentlyContinue


Write-Output "Kali VMs are now deleted"
Remove-VM $VM_Name -force -ErrorAction SilentlyContinue



Write-Output "$VM_Name directory will be deleted"

Get-ChildItem -Path "D:\Lab\Teilnehmer_$participant_number" -Recurse | Where-Object {$_.Name -eq "$VM_Name"} | Remove-Item -Recurse

#Zurück zum Startmenü
. $script_path\Start.ps1


