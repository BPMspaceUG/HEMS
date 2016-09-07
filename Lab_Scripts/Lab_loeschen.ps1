# Komplettes Lab löschen

# Anzahl der angelegten VMs ermitteln

$VMs = Get-VM
$VMAnzahl = $VMs.count
$TN_VM = $VMAnzahl - 3

Write-Output "Es werden nun $TN_VM VMs gelöscht."

Write-Output "Kali VMs werden angehalten"
Stop-VM kali.lab* -TurnOff -force -ErrorAction SilentlyContinue

Write-Output "Metasploitable VMs werden angehalten"
Stop-VM linux.lab* -TurnOff -force -ErrorAction SilentlyContinue

Write-Output "Windows VMs werden angehalten"
Stop-VM windows.lab* -TurnOff -force -ErrorAction SilentlyContinue

Write-Output "Kali VMs werden entfernt"
Remove-VM kali.lab* -force -ErrorAction SilentlyContinue

Write-Output "Metasploitable VMs werden entfernt"
Remove-VM linux.lab* -force -ErrorAction SilentlyContinue

Write-Output "Windows VMs werden entfernt"
Remove-VM windows.lab* -force -ErrorAction SilentlyContinue

Write-Output "Teilnehmerverzeichnisse werden gelöscht"
Get-ChildItem -Path "D:\Lab\" -Recurse | Where-Object {$_.Name -like "Teilnehmer_*"} | Remove-Item -Recurse

#Zurück zum Startmenü
. $script_path\Start.ps1


