# Komplettes Lab herunterfahren

# Anzahl der angelegten VMs ermitteln

$VMs = Get-VM
$VMAnzahl = $VMs.count
$TN_VM = $VMAnzahl - 3

Write-Output "Es werden nun $TN_VM VMs heruntergefahren."

Stop-VM kali.lab* -Force
Stop-VM linux.lab* -Force
stop-VM windows.lab* -Force

#Zurück zum Startmenü
. $script_path\Start.ps1