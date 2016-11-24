param (
$participant_number
)

Write-Output $participant_number
Start-Sleep 1

# Deletes the complete Lab
$script_path = "C:\Hems-Repository\Lab_Scripts" # on MITSM_HYPERV_04

# Gets the number of all VMs

$VMs = Get-VM "*-lab*"
$VM_count = $VMs.count

Write-Output "Es werden nun $VM_count VMs gelöscht."

Stop-VM "*-lab*" -TurnOff -force -ErrorAction SilentlyContinue
Remove-VM "*-lab*" -force -ErrorAction SilentlyContinue

Write-Output "Participant directories will be deleted"
Get-ChildItem -Path "D:\Lab\" -Recurse | Where-Object {$_.Name -like "Teilnehmer_*"} | Remove-Item -Recurse

if ($participant_number) {
    . $script_path\Manage-Lab\Create-Lab.ps1 -participant_number $participant_number
}

else {
#Zurück zum Startmenü
. $script_path\Start.ps1

}
