# Allgemeine Parameter

$script_path = "C:\Hems-Repository\Lab_Scripts" # on MITSM_HYPERV_04

#Start des Skriptes

$participant_number = [convert]::ToInt32((Read-Host "Für welchen Teilnehmer soll die Umgebung neugestartet werden?"), 10)
$participant_number = "{0:00}" -f $participant_number

$Kali_VMName="kali.lab$participant_number.net"
$MS_VMName="linux.lab$participant_number.net"
$Win_VMName="windows.lab$participant_number.net"
$WinServ_VMName="winserver.lab$participant_number.net"

###VMs herunterfahren
Write-Output "Kali-VM wird heruntergefahren."
stop-vm $Kali_VMName

Write-Output "Linux-VM wird heruntergefahren."
stop-vm $MS_VMName

Write-Output "Windows-VM wird heruntergefahren."
stop-vm $Win_VMName

Write-Output "WindowsServer-VM wird heruntergefahren."
stop-vm $WinServ_VMName


#Zurück zum Startmenü
. $script_path\Start.ps1