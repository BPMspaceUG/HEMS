# General parameters
$drive = "D:"
$childpath = "$drive\Lab\Teilnehmer_"

#$script_path = "C:\Users\Christian\OneDrive\Studium\Masterarbeit\mITSM\Skripte\Lab_Scripts"
$script_path = "C:\HEMS-Repository\Lab_Scripts" # auf MITSM_HYPERV_04


# Get participant number

$participant_number = [convert]::ToInt32((Read-Host "Für welchen Teilnehmer soll die Umgebung gelöscht werden?"), 10)
$participant_number = "{0:00}" -f $participant_number


# Lab löschen
. $script_path\Manage-Environment\Delete-Environment.ps1 -participant_number $participant_number

# Lab neuaufsetzen
. $script_path\Manage-Lab\Create-Environment.ps1 -participant_number $participant_number

#Zurück zum Startmenü
. $script_path\Start.ps1