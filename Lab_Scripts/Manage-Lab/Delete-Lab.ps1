param (
$participant_number
)

# Deletes the complete Lab
$script_path = "C:\Hems-Repository\Lab_Scripts" # on MITSM_HYPERV_04

# Gets the number of all VMs

$VMs = Get-VM
$VM_count = $VMs.count

Write-Output "Es werden nun $VM_count VMs gelöscht."

Write-Output "Kali VMs are now shuting down"
Stop-VM kali.lab* -TurnOff -force -ErrorAction SilentlyContinue

Write-Output "Metasploitable VMs are now stopping"
Stop-VM linux.lab* -TurnOff -force -ErrorAction SilentlyContinue

Write-Output "Windows VMs are now stopping"
Stop-VM windows.lab* -TurnOff -force -ErrorAction SilentlyContinue

Write-Output "Windows Server VMs are now stopping"
Stop-VM winserver.lab* -TurnOff -force -ErrorAction SilentlyContinue

Write-Output "Kali VMs are now deleted"
Remove-VM kali.lab* -force -ErrorAction SilentlyContinue

Write-Output "Metasploitable VMs are now deleted"
Remove-VM linux.lab* -force -ErrorAction SilentlyContinue

Write-Output "Windows VMs are now deleted"
Remove-VM windows.lab* -force -ErrorAction SilentlyContinue

Write-Output "Windows Server VMs are now deleted"
Remove-VM winserver.lab* -force -ErrorAction SilentlyContinue

Write-Output "Participant directories will be deleted"
Get-ChildItem -Path "D:\Lab\" -Recurse | Where-Object {$_.Name -like "Teilnehmer_*"} | Remove-Item -Recurse

if ($participant_number) {
    . $script_path\Manage-Lab\Create-Lab.ps1 -participant_number $participant_number
}

else {
#Zurück zum Startmenü
. $script_path\Start.ps1

}
