# Module Create-DifferencingVM

Function Create-DifferencingVM
{

param
(
$TemplatePath,
$VHDX_Path,
$VM_Name,
$VM_Path,
$VM_Switch,
$MemMaxBytes,
$MemMinBytes,
$MemStartupBytes,
$VM_Cores,
$VM_StaticMac
)      



        Function Main {       
        # Create new differencing VHDX 
        New-VHD -ParentPath "$TemplatePath" -Differencing -Path "$VHDX_Path"
         
        # Create new VM and assign the new VHDX and a Virtual Switch
        New-VM -VHDPath "$VHDX_Path" -Name $VM_Name -Path "$VM_Path" -SwitchName $VM_Switch
         
        # Configure the new VM
        Set-VM -Name $VM_Name -DynamicMemory -MemoryMaximumBytes $MemMaxBytes -MemoryMinimumBytes $MemMinBytes -MemoryStartupBytes $MemStartupBytes -ProcessorCount $VM_Cores

        # Assigns a new, but static Mac-Address to the Virtual NIC
        Get-VM -Name $VM_Name | Get-VMNetworkAdapter | Set-VMNetworkAdapter -StaticMacAddress $VM_StaticMac

        #Enabling all Integration Services
        Enable-VMIntegrationService -VMName $VM_Name -Name "Guest Service Interface"
        }
}
