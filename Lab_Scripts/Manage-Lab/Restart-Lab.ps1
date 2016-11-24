# Komplettes Lab neustarten
$script_path = "C:\HEMS-Repository\Lab_Scripts" # auf MITSM_HYPERV_04

# Anzahl der angelegten VMs ermitteln
$VMs = Get-VM "*-lab*"
$VM_count = $VMs.count


Write-Output "$VM_count VMs are going to restart now."

$err = @()
Restart-VM "*-lab*" -Force -EA SilentlyContinue -ErrorVariable err

if ($err) {
    Stop-VM "*-lab*" -TurnOff -Force
    Start-VM "*-lab*"
    }

#Zurück zum Startmenü
. $script_path\Start.ps1