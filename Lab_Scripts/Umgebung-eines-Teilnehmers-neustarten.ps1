# Allgemeine Parameter
$drive = "D:"
$childpath = "$drive\Lab\Teilnehmer_"

#Start des Skriptes

$TN_Nr = [convert]::ToInt32((Read-Host "Für welchen Teilnehmer soll die Umgebung neugestartet werden?"), 10)
$TN_Nr = "{0:00}" -f $TN_Nr

$Kali_VMName="kali.lab$TN_Nr.net"
$MS_VMName="linux.lab$TN_Nr.net"
$Win_VMName="windows.lab$TN_Nr.net"

###VMs herunterfahren
Write-Output "Kali-VM wird heruntergefahren."
stop-vm $Kali_VMName

Write-Output "Linux-VM wird heruntergefahren."
stop-vm $MS_VMName

Write-Output "Windows-VM wird heruntergefahren."
stop-vm $Win_VMName


### VMs starten

Write-Output "Kali-VM wird neugestartet."
start-vm $Kali_VMName

Write-Output "Linux-VM wird neugestartet."
start-vm $MS_VMName

Write-Output "Windows-VM wird neugestartet."
start-vm $Win_VMName

#Zurück zum Startmenü
. $script_path\Start.ps1