# Allgemeine Parameter

$script_path = "C:\Hems-Repository\Lab_Scripts" # on MITSM_HYPERV_04

#Start des Skriptes

$participant_number = [convert]::ToInt32((Read-Host "Die Metasploitable VM welches Teilnehmers soll neugestartet werden?"), 10)
$participant_number = "{0:00}" -f $participant_number

$VM_Name="linux.lab$participant_number.net"


###VM herunterfahren
Write-Output "$VM_Name wird heruntergefahren."
stop-vm $VM_Name -TurnOff -force


### VM starten

Write-Output "$VM_Name wird neugestartet."
start-vm $VM_Name


#Zurück zum Startmenü
. $script_path\Start.ps1