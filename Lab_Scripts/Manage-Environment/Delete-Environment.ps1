param (
[string]$participant_number
)

# Deletes the complete Lab
$script_path = "C:\Hems-Repository\Lab_Scripts" # on MITSM_HYPERV_04

# Gets the number of all VMs

if (!$participant_number) { # Test, ob bereits ein Wert für TN_Nr übergeben wurde 
$participant_number = [convert]::ToInt32((Read-Host "Für welchen Teilnehmer soll die Umgebung gelöscht werden?"), 10)
$participant_number = "{0:00}" -f $participant_number
}

$Kali_VMName="kali.lab$participant_number.net"
$MS_VMName="linux.lab$participant_number.net"
$Win_VMName="windows.lab$participant_number.net"
$WinServ_VMName="winserver.lab$participant_number.net"

Write-Output "Es werden nun $VM_count VMs gelöscht."

Write-Output "Kali VMs are now shuting down"
Stop-VM $Kali_VMName -TurnOff -force -ErrorAction SilentlyContinue

Write-Output "Metasploitable VMs are now stopping"
Stop-VM $MS_VMName -TurnOff -force -ErrorAction SilentlyContinue

Write-Output "Windows VMs are now stopping"
Stop-VM $Win_VMName -TurnOff -force -ErrorAction SilentlyContinue

Write-Output "Windows Server VMs are now stopping"
Stop-VM $WinServ_VMName -TurnOff -force -ErrorAction SilentlyContinue

Write-Output "Kali VMs are now deleted"
Remove-VM $Kali_VMName -force -ErrorAction SilentlyContinue

Write-Output "Metasploitable VMs are now deleted"
Remove-VM $MS_VMName -force -ErrorAction SilentlyContinue

Write-Output "Windows VMs are now deleted"
Remove-VM $Win_VMName -force -ErrorAction SilentlyContinue

Write-Output "Windows Server VMs are now deleted"
Remove-VM $WinServ_VMName -force -ErrorAction SilentlyContinue

Write-Output "Participant directoriy will be deleted"

Get-ChildItem -Path "D:\Lab\" -Recurse | Where-Object {$_.Name -eq "Teilnehmer_$participant_number"} | Remove-Item -Recurse

#Zurück zum Startmenü
. $script_path\Start.ps1


