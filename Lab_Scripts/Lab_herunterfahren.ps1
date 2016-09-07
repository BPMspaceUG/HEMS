# Komplettes Lab herunterfahren

# Anzahl der angelegten VMs ermitteln

$VMs = Get-VM
$VMAnzahl = $VMs.count
$TN_VM = $VMAnzahl - 3

Write-Output "Es werden nun $TN_VM VMs heruntergefahren."

Stop-VM kali.lab* -TurnOff -Force
Stop-VM linux.lab* -TurnOff -Force
stop-VM windows.lab* -TurnOff -Force

#Zurück zum Startmenü
. $script_path\Start.ps1