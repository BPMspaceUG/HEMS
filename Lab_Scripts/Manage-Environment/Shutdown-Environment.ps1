# Allgemeine Parameter

$script_path = "C:\Hems-Repository\Lab_Scripts" # on MITSM_HYPERV_04

#Start des Skriptes

$participant_number = [convert]::ToInt32((Read-Host "Für welchen Teilnehmer soll die Umgebung neugestartet werden?"), 10)
$participant_number = "{0:00}" -f $participant_number

Stop-VM "*-lab$participant_number" -TurnOff -Force

#Zurück zum Startmenü
. $script_path\Start.ps1