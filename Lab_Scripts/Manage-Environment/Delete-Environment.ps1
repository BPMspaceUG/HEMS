param (
[string]$participant_number
)

# Deletes the complete Lab
$script_path = "C:\Hems-Repository\Lab_Scripts" # on MITSM_HYPERV_04

# Gets the number of all VMs

if (!$participant_number) { # Test, ob bereits ein Wert für TN_Nr übergeben wurde 
$participant_number = [convert]::ToInt32((Read-Host "Please enter the Number of the Participant for which you want to delete the environment:"), 10)
$participant_number = "{0:00}" -f $participant_number
}

Write-Output "The Environment of participant $participant_number will be deleted:"

Stop-VM "*lab$participant_number" -TurnOff -force -ErrorAction SilentlyContinue
Remove-VM "*lab$participant_number" -force -ErrorAction SilentlyContinue


Write-Output "Participant directoriy will be deleted"
Get-ChildItem -Path "D:\Lab\" -Recurse | Where-Object {$_.Name -eq "Teilnehmer_$participant_number"} | Remove-Item -Recurse

if ($participant_number) {
    . $script_path\Manage-Environment\Create-Environment.ps1 -participant_number $participant_number
}

else {
#Zurück zum Startmenü
. $script_path\Start.ps1

}