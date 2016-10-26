# General parameters
$drive = "D:"
$childpath = "$drive\Lab\Teilnehmer_"

#$script_path = "C:\Users\Christian\OneDrive\Studium\Masterarbeit\mITSM\Skripte\Lab_Scripts"
$script_path = "C:\HEMS-Repository\Lab_Scripts" # auf MITSM_HYPERV_04

$VM_Name = "KaliVM"

# Get participant number

$participant_number = [convert]::ToInt32((Read-Host "Reset der $VM_Name von Teilnehmer: "), 10)
$participant_number = "{0:00}" -f $participant_number


# Lab löschen
. $script_path\Manage-VM\Delete-$VM_Name.ps1 -participant_number $participant_number

# Lab neuaufsetzen
. $script_path\Manage-VM\Create-$VM_Name.ps1 -participant_number $participant_number

#Zurück zum Startmenü
. $script_path\Start.ps1