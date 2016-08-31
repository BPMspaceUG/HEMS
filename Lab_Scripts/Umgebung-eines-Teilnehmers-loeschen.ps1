param (
[string]$TN_Nr
)

# Allgemeine Parameter
$drive = "D:"
$childpath = "$drive\Lab\Teilnehmer_"

#Start des Skriptes
if (!$TN_Nr) { # Test, ob bereits ein Wert für TN_Nr übergeben wurde 
$TN_Nr = [convert]::ToInt32((Read-Host "Für welchen Teilnehmer soll die Umgebung gelöscht werden?"), 10)
$TN_Nr = "{0:00}" -f $TN_Nr
}

$Kali_VMName="kali.lab$TN_Nr.net"
$MS_VMName="linux.lab$TN_Nr.net"
$Win_VMName="windows.lab$TN_Nr.net"

try {
   Stop-VM "$Kali_VMName" -Force -ErrorAction SilentlyContinue
}
catch {
   write-output "Kali VM wurde nicht gefunden. Ausführung wird fortgesetzt"
}

try {
   Stop-VM "$MS_VMName" -Force -ErrorAction SilentlyContinue
}
catch {
   write-output "Metasploitable VM wurde nicht gefunden. Ausführung wird fortgesetzt"
}

try {
   Stop-VM "$Win_VMName" -Force -ErrorAction SilentlyContinue
}
catch {
   write-output "Windows VM wurde nicht gefunden. Ausführung wird fortgesetzt"
}


#Stop-VM "$Kali_VMName" -Force -ErrorAction SilentlyContinue 
#Stop-VM "$MS_VMName" -Force -ErrorAction SilentlyContinue
#Stop-VM "$Win_VMName" -Force -ErrorAction SilentlyContinue

Write-Output "Ausführung wird in 5 Sekunden fortgesetzt"
foreach ($i in 5..1){
Write-Output "$i"
Start-Sleep -Seconds 1
}

#Entferne Kali VM
try {
Remove-VM "$Kali_VMName" -Force -ErrorAction SilentlyContinue
}
catch {
write-output "Kali Verzeichnis nicht gefunden. Ausführung wird fortgesetzt."
}


#Entferne Metasploitable VM
try{
Remove-VM "$MS_VMName" -Force -ErrorAction SilentlyContinue
}
catch {
write-output "Kali Verzeichnis nicht gefunden. Ausführung wird fortgesetzt."
}
#Entferne Windows VM
try{
Remove-VM "$Win_VMName" -Force -ErrorAction SilentlyContinue
}
catch {
write-output "Kali Verzeichnis nicht gefunden. Ausführung wird fortgesetzt."
}
#Entferne den Teilnehmerordner
Remove-Item "$childpath$TN_Nr" -Recurse -Force -ErrorAction SilentlyContinue

Write-Output "Umgebung für Teilnehmer $TN_Nr gelöscht"

#Zurück zum Startmenü
. $script_path\Start.ps1