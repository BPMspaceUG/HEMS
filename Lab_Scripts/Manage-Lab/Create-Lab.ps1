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


#Metasploitable VM
$ms_vm_type = "02"
$ms_template_path = "$template_location\_Metasploitable_Template\_Metasploitable_Template.vhdx"

#Windows VM
$win_vm_type = "03"
$win_template_path = "$template_location\_Windows_Template\_Windows_Template.vhdx"

#Windows Server VM
$winserv_vm_type = "04"
$winserv_template_path = "$template_location\_Windows_Server_Template\_Windows_Server_Template.vhdx"


#################Beginn of Script##############

#Shutdown Template VMs
get-vm -name "*_Template" | stop-vm -force -ErrorAction SilentlyContinue

# Sets the rights to read-only
. $script_path\Manage-VM\Enable-ReadMode.ps1

#Question for number of participants

if (!$participant_number) 
{
    $participant_number = [convert]::ToInt32((Read-Host "How many participants has this course?"), 10)
}
$VM_count = (($participant_number + 1) * 3) + 1
$participant_number = "{0:00}" -f $participant_number

Write-Output `n "$participant_number attendees will participate." `n
Write-Output "$VM_count VMs will now be generated ."

Write-Output "------------------------------------------------------------" `n
Start-Sleep -Seconds 3


foreach ($i in 0..$participant_number)
           {
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
          
                #Create Kali VM Clones
                $Kali_VMName="kali.lab$i.net"
                $Kali_MAC = "$mac_scope$kali_vm_type$Hex_i"
                $kali_participant_vhd_path = "$participant_path\$Kali_VMName\$Kali_VMName.VHDX"       

                . $module_path\Create-DifferencingVM_Kali.ps1 -TemplatePath "$kali_template_path" -VHDX_Path "$kali_participant_vhd_path" -VM_Name $Kali_VMName -VM_Path $participant_path -VM_Switch $vSwitch -VM_StaticMac $Kali_MAC 

                Write-Output "$Kali_VMName created"
                Write-Output "MAC-Address: $Kali_MAC"

                #Create Metasploitable VM Clones
                $MS_VMName="linux.lab$i.net"
                $MS_MAC = "$mac_scope$ms_vm_type$Hex_i"
                $ms_participant_vhd_path = "$participant_path\$MS_VMName\$MS_VMName.VHDX"       
                
                . $module_path\Create-DifferencingVM_MS.ps1 -TemplatePath "$ms_template_path" -VHDX_Path "$ms_participant_vhd_path" -VM_Name $MS_VMName -VM_Path $participant_path -VM_Switch $vSwitch -VM_StaticMac $MS_MAC 

                Write-Output "$MS_VMName created"
                Write-Output "MAC-Address: $MS_MAC"

                #Create Windows VM Clones
                $Win_VMName="windows.lab$i.net"
                $Win_MAC = "$mac_scope$win_vm_type$Hex_i"
                $win_participant_vhd_path = "$participant_path\$Win_VMName\$Win_VMName.VHDX"       

                . $module_path\Create-DifferencingVM_Win.ps1 -TemplatePath "$win_template_path" -VHDX_Path "$win_participant_vhd_path" -VM_Name $Win_VMName -VM_Path $participant_path -VM_Switch $vSwitch -VM_StaticMac $Win_MAC 
                
                # Create Windows Server VM Clone only for the trainer --> only if $i = 0
                if ($i -eq "00")
                    {
                    $Winserv_VMName = "winserver.lab$i.net"
                    $Winserv_MAC = "$mac_scope$winserv_vm_type$Hex_i"
                    $winserv_participant_vhd_path = "$participant_path\$Winserv_VMName\$Winserv_VMName.VHDX"          
                    . $module_path\Create-DifferencingVM_WinServer.ps1 -TemplatePath "$winserv_template_path" -VHDX_Path "$winserv_participant_vhd_path" -VM_Name $WinServ_VMName -VM_Path $participant_path -VM_Switch $vSwitch -VM_StaticMac $Winserv_MAC 
                    }
        }

}

Write-Output "------------------------------------------------------------" `n
Write-Output "$VM_count VMs have been created"
Start-Sleep -Seconds 5

#Back to Startmenu
. $script_path\Start.ps1

