# Komplettes Lab neustarten


# Anzahl der angelegten VMs ermitteln
$VMs = Get-VM
$VMAnzahl = $VMs.count
$TN_VM = $VMAnzahl - 3

Write-Output "Es werden nun $TN_VM VMs neugestartet."

Stop-VM kali.lab* -Force
Stop-VM linux.lab* -Force
Stop-VM windows.lab* -Force

Start-VM kali.lab* 
Start-VM linux.lab*
Start-VM windows.lab*

#Zurück zum Startmenü
. $script_path\Start.ps1