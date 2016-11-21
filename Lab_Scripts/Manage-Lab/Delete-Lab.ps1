param (
$participant_number
)

Write-Output $participant_number
Start-Sleep 1

# Deletes the complete Lab
$script_path = "C:\Hems-Repository\Lab_Scripts" # on MITSM_HYPERV_04

# Gets the number of all VMs

$VMs = Get-VM
$VM_count = $VMs.count

$Kali_VMName="kali-lab*"
$MS_VMName="linux-lab*"
$Win_VMName="windows-lab*"
$Winserv_VMName = "winserver-lab*"

Write-Output "Es werden nun $VM_count VMs gelöscht."

Write-Output "Kali VMs are now shuting down"
Stop-VM $Kali_VMName -TurnOff -force -ErrorAction SilentlyContinue

Write-Output "Metasploitable VMs are now stopping"
Stop-VM $MS_VMName -TurnOff -force -ErrorAction SilentlyContinue

Write-Output "Windows VMs are now stopping"
Stop-VM $Win_VMName -TurnOff -force -ErrorAction SilentlyContinue

Write-Output "Windows Server VMs are now stopping"
Stop-VM $Winserv_VMName -TurnOff -force -ErrorAction SilentlyContinue

Write-Output "Kali VMs are now deleted"
Remove-VM $Kali_VMName -force -ErrorAction SilentlyContinue

Write-Output "Metasploitable VMs are now deleted"
Remove-VM $MS_VMName -force -ErrorAction SilentlyContinue

Write-Output "Windows VMs are now deleted"
Remove-VM $Win_VMName -force -ErrorAction SilentlyContinue

Write-Output "Windows Server VMs are now deleted"
Remove-VM $Winserv_VMName -force -ErrorAction SilentlyContinue

Write-Output "Participant directories will be deleted"
Get-ChildItem -Path "D:\Lab\" -Recurse | Where-Object {$_.Name -like "Teilnehmer_*"} | Remove-Item -Recurse

if ($participant_number) {
    . $script_path\Manage-Lab\Create-Lab.ps1 -participant_number $participant_number
}

else {
#Zurück zum Startmenü
. $script_path\Start.ps1

}
