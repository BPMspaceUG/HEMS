# General parameters
$drive = "D:"
$childpath = "$drive\Lab\Teilnehmer_"

#$script_path = "C:\Users\Christian\OneDrive\Studium\Masterarbeit\mITSM\Skripte\Lab_Scripts"
$script_path = "C:\HEMS-Repository\Lab_Scripts" # auf MITSM_HYPERV_04


# Get Number of VMs

$VMs = Get-VM
$VM_count = $VMs.count -4 # The templates are in the "get-vm" list, but they should not be deleted
$participant_number = $VM_count / 3

# Lab löschen
. $script_path\Manage-Lab\Delete-Lab.ps1

# Lab neuaufsetzen
. $script_path\Manage-Lab\Create-Lab.ps1 -participant_number $participant_number

#Zurück zum Startmenü
. $script_path\Start.ps1