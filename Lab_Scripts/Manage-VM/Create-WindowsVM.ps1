# Defines external Parameters
param (
$participant_number
)

# Global Variables
$drive = "D:"
$template_location = "C:\VM-Templates"
$trainer_location = "$drive\Lab\Trainer"
$participant_location = "$drive\Lab\Teilnehmer_"
$participant_path = "$participant_location$i"
$vSwitch = "Lab_Switch"
$script_path = "C:\Hems-Repository\Lab_Scripts" # auf MITSM_HYPERV_04
$module_path = "C:\Hems-Repository\Lab_Scripts\modules"
$mac_scope = "00155DB2"


#Section for Module Imports
#Import-Module Create-DifferencingVM



#Windows VM
$win_vm_type = "03"
$win_template_path = "$template_location\_Windows_Template\_Windows_Template.vhdx"



#################Beginn of Script##############

#Shutdown Template VMs
get-vm -name "*_Template" | stop-vm -force -ErrorAction SilentlyContinue

# Sets the rights to read-only
. $script_path\Manage-VM\Enable-ReadMode.ps1

#Question for number of participants

if (!$participant_number) 
{
    $participant_number = [convert]::ToInt32((Read-Host "For which participant do you want to create the Environment?"), 10)
}
$i = "{0:00}" -f $participant_number

Write-Output `n "Environment for attendee $participant_number is now created ." `n

Write-Output "------------------------------------------------------------" `n
Start-Sleep -Seconds 3


    $vm = Get-VM -name "*.lab$i.net" -ErrorAction SilentlyContinue #Checks, if some VMs exist already
    
    if ($vm){
     Write-Output "The following VMs exist already:" 
     Write-Output "kali.lab$i.net" "linux.lab$i.net" "windows.lab$i.net"
     Write-Output "$($vm.State)" `n 
     # TODO: Question, if these VMs schould rest or schould be deleted
     Write-Output "Those VMs will stay for the moment." `n
    }
    else{

                $i = [convert]::ToInt32($i, 10)
                $i = "{0:00}" -f $i

                $Hex_i = [convert]::ToInt32($i, 10)
                $Hex_i = "{0:X2}" -f $Hex_i  
          
                
                #Create Windows VM Clones
                $Win_VMName="windows.lab$i.net"
                $Win_MAC = "$mac_scope$win_vm_type$Hex_i"
                $win_participant_vhd_path = "$participant_path\$Win_VMName\$Win_VMName.VHDX"       

                . $module_path\Create-DifferencingVM_Win.ps1 -TemplatePath "$win_template_path" -VHDX_Path "$win_participant_vhd_path" -VM_Name $Win_VMName -VM_Path $participant_path -VM_Switch $vSwitch -VM_StaticMac $Win_MAC 
                
               
        }

Write-Output "------------------------------------------------------------" `n
Write-Output "$Win_VMName VMs have been created"
Start-Sleep -Seconds 5

#Back to Startmenu
. $script_path\Start.ps1

