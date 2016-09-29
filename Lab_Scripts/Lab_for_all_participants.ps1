# Defines external Parameters
param (
[int]$P_count
)

#Section for Module Imports


# Global Variables
$drive = "D:"
$template_location = "$drive\VM-Templates\"
$trainer_location = "$drive\Lab\Trainer"
$participant_location = "$drive\Lab\Teilnehmer_"
$vSwitch = "Lab_Switch"
$script_location = "C:\Hems-Repository\Lab_Scripts" # auf MITSM_HYPERV_04
$mac_scope = "00155DB2"
# Kali VM
$kali_vm_type = "01"
$Kali_MemMinBytes = 256MB
$Kali_MemMaxBytes = 1042MB
$Kali_MemStartupBytes = 256MB
$Kali_VM_Cores = 2
#Metasploitable VM
$ms_vm_type = "02"
$MS_MemMinBytes = 256MB
$MS_MemMaxBytes = 512MB
$MS_MemStartupBytes = 512MB
$MS_VM_Cores = 2
#Windows VM
$win_vm_type = "03"
$Win_MemMinBytes = 256MB
$Win_MemMaxBytes = 1024MB
$Win_MemStartupBytes = 1024MB
$Win_VM_Cores = 2


#################Beginn of Script##############

# Sets the rights to read-only
. $script_location\TemplateVHD-Schreibschutz-setzen.ps1

#Question for number of participants

if (!$P_count) {
$P_count = [convert]::ToInt32((Read-Host "Wie viele Teilnehmer werden am Kurs teilnehmen?"), 10) 
}
$VM_count = $P_count * 3
$P_count = "{0:00}" -f $P_count

Write-Output `n "$P_count attendees will participate." `n
Write-Output "$VM_count VMs will now be generated ."

Write-Output "------------------------------------------------------------" `n
Start-Sleep -Seconds 3

$trainer_vm = Get-VM -name "*.trainer.net" -ErrorAction SilentlyContinue #Checks, if the trainer VMs exist already
if ($trainer_vm)
    {
        Write-Output "Trainer VMs exist already. Do you want to restore them to the default configuration?"
    }
else 
{
            # Trainer Lab
            $trainer_mac = "00"
            $trainer_path = "$trainer_location"
            

            # Kali Trainer VM
            $Kali_VMName="kali.trainer.net"
            $kali_template_path = "$template_location\_Kali_Template\_Kali_Template.vhdx"
            $kali_trainer_vhd_path = "$trainer_location\$Kali_VMName\$Kali_VMName.VHDX" 
            $Kali_MAC = "$mac_scope$kali_vm_type$trainer_mac"

            Create-DifferencingVM -TemplatePath "$kali_template_path" -VHDX_Path "$kali_trainer_vhd_path" -VM_Name $Kali_VMName -VM_Path $trainer_path -VM_Switch $vSwitch -MemMaxBytes $Kali_MemMaxBytes -MemMinBytes $Kali_MemMinBytes -MemStartupBytes $Kali_MemStartupBytes -VM_Cores $Kali_VM_Cores -VM_StaticMac $Kali_MAC 

            # Metasploitable Trainer VM
            $MS_VMName = "linux.trainer.net"
            $ms_template_path = "$template_location\_Metasploitable_Template\_Metasploitable_Template.vhdx"
            $ms_trainer_vhd_path = "$trainer_location\$MS_VMName\$MS_VMName.VHDX" 
            $MS_MAC = "$mac_scope$ms_vm_type$trainer_mac"
            
            Create-DifferencingVM -TemplatePath "$ms_template_path" -VHDX_Path "$ms_trainer_vhd_path" -VM_Name $MS_VMName -VM_Path $trainer_path -VM_Switch $vSwitch -MemMaxBytes $MS_MemMaxBytes -MemMinBytes $MS_MemMinBytes -MemStartupBytes $MS_MemStartupBytes -VM_Cores $MS_VM_Cores -VM_StaticMac $MS_MAC 

            # Windows Trainer VM
            $Win_VMName = "windows.trainer.net"
            $win_template_path = "$template_location\_Kali_Template\_Kali_Template.vhdx"
            $win_trainer_vhd_path = "$trainer_location\$Kali_VMName\$Kali_VMName.VHDX" 
            $Win_MAC = "$mac_scope$win_vm_typedows$trainer_mac"
            
            Create-DifferencingVM -TemplatePath "$win_template_path" -VHDX_Path "$win_trainer_vhd_path" -VM_Name $Win_VMName -VM_Path $trainer_path -VM_Switch $vSwitch -MemMaxBytes $Win_MemMaxBytes -MemMinBytes $Win_MemMinBytes -MemStartupBytes $Win_MemStartupBytes -VM_Cores $Win_VM_Cores -VM_StaticMac $Win_MAC 

                     
}    

$vm = Get-VM -name "*.lab$i.net" -ErrorAction SilentlyContinue #Checks, if some VMs exist already
    if ($vm){
     Write-Output "The following VMs exist already:" 
     Write-Output "kali.lab$i.net" "linux.lab$i.net" "windows.lab$i.net"
     Write-Output "$($vm.State)" `n 
     # TODO: Question, if these VMs schould rest or schould be deleted
     Write-Output "Those VMs will stay for the moment." `n
    }
    else{

        foreach ($i in 1..$P_count)
           {

           
            $i = [convert]::ToInt32($i, 10)
            $i = "{0:00}" -f $i

            $Hex_i = [convert]::ToInt32($i, 10)
            $Hex_i = "{0:X2}" -f $Hex_i
         
          
                #Create Kali VM Clones
                $Kali_VMName="kali.lab$i.net"
                $Kali_MAC = "$mac_scope$kali_vm_type$Hex_i"
                $kali_template_path = "$template_location\Kali_Training\Kali_Training.vhdx"
                $kali_participant_vhd_path = "$participant_location$i\$Kali_VMName\$Kali_VMName.VHDX"       
                $participant_path = "$participant_location$i"

                Create-DifferencingVM -TemplatePath "$kali_template_path" -VHDX_Path "$kali_participant_vhd_path" -VM_Name $Kali_VMName -VM_Path $participant_path -VM_Switch $vSwitch -MemMaxBytes $Kali_MemMaxBytes -MemMinBytes $Kali_MemMinBytes -MemStartupBytes $Kali_MemStartupBytes -VM_Cores $Kali_VM_Cores -VM_StaticMac $Kali_MAC 

                Write-Output "$Kali_VMName created"
                Write-Output "MAC-Address: $Kali_MAC"
                Start-VM "$Kali_VMName" 

                #Create Metasploitable VM Clones
                $MS_VMName="linux.lab$i.net"
                $MS_MAC = "$mac_scope$ms_vm_type$Hex_i"
                $ms_template_path = "$template_location\_Metasploitable_Template\_Metasploitable_Template.vhdx"
                $ms_participant_vhd_path = "$participant_location$i\$MS_VMName\$MS_VMName.VHDX"       
                $participant_path = "$participant_location$i"
                
                Create-DifferencingVM -TemplatePath "$kali_template_path" -VHDX_Path "$kali_participant_vhd_path" -VM_Name $Kali_VMName -VM_Path $participant_path -VM_Switch $vSwitch -MemMaxBytes $MS_MemMaxBytes -MemMinBytes $MS_MemMinBytes -MemStartupBytes $MS_MemStartupBytes -VM_Cores $MS_VM_Cores -VM_StaticMac $Kali_MAC 

                Write-Output "$MS_VMName created"
                Write-Output "MAC-Address: $MS_MAC"
                Start-VM "$Kali_VMName" 

                #Create Windows VM Clones
                $MS_VMName="windows.lab$i.net"
                $Win_MAC = "$mac_scope$win_vm_type$Hex_i"
                $win_template_path = "$template_location\_Windows_Template\_Windows_Template.vhdx"
                $win_participant_vhd_path = "$participant_location$i\$Win_VMName\$Win_VMName.VHDX"       
                $participant_path = "$participant_location$i"

                Create-DifferencingVM -TemplatePath "$kali_template_path" -VHDX_Path "$kali_participant_vhd_path" -VM_Name $Kali_VMName -VM_Path $participant_path -VM_Switch $vSwitch -MemMaxBytes $Win_MemMaxBytes -MemMinBytes $Win_MemMinBytes -MemStartupBytes $Win_MemStartupBytes -VM_Cores $Win_VM_Cores -VM_StaticMac $Kali_MAC 


                Write-Output "$VM_count VMs have been created"
                }

}

Write-Output "------------------------------------------------------------" `n
Start-Sleep -Seconds 5

#Zurück zum Startmenü
. $script_location\Start.ps1

