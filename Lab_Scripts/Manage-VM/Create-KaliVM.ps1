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

# Kali VM
$kali_vm_type = "01"
$kali_template_path = "$template_location\_Kali_Template\_Kali_Template.vhdx"



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

Write-Output `n "Kali VM for attendee $participant_number is now created ." `n

Write-Output "------------------------------------------------------------" `n
Start-Sleep -Seconds 3


    $vm = Get-VM -name "*.lab$i.net" -ErrorAction SilentlyContinue #Checks, if some VMs exist already
    
    if ($vm){
     Write-Output "The following VMs exist already:" 
     Write-Output "kali.lab$i.net"
     Write-Output "$($vm.State)" `n 
     # TODO: Question, if these VMs schould rest or schould be deleted
     Write-Output "Those VMs will stay for the moment." `n
    }
    else{

                $i = [convert]::ToInt32($i, 10)
                $i = "{0:00}" -f $i

                $Hex_i = [convert]::ToInt32($i, 10)
                $Hex_i = "{0:X2}" -f $Hex_i  
          
                #Create Kali VM Clones
                $Kali_VMName="kali.lab$i.net"
                $Kali_MAC = "$mac_scope$kali_vm_type$Hex_i"
                $kali_participant_vhd_path = "$participant_path\$Kali_VMName\$Kali_VMName.VHDX"       

                . $module_path\Create-DifferencingVM_Kali.ps1 -TemplatePath "$kali_template_path" -VHDX_Path "$kali_participant_vhd_path" -VM_Name $Kali_VMName -VM_Path $participant_path -VM_Switch $vSwitch -VM_StaticMac $Kali_MAC 

                Write-Output "$Kali_VMName created"
                Write-Output "MAC-Address: $Kali_MAC"

                

Write-Output "------------------------------------------------------------" `n
Write-Output "$Kali_VMName VMs have been created"
Start-Sleep -Seconds 5

#Back to Startmenu
. $script_path\Start.ps1

