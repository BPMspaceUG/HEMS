﻿# Shutdown Lab

$script_path = "C:\Hems-Repository\Lab_Scripts"

# Gets all necessary VMs running

$VMs = Get-VM -Name linux.lab*
$VM_count = $VMs.count

Write-Output "$VM_count VMs are going to shutdown now."

Stop-VM linux.lab* -TurnOff -Force


#Zurück zum Startmenü
. $script_path\Start.ps1