# Module Create-DifferencingVM

param
(
$TemplatePath,
$VHDX_Path,
$DirectoryPath,
$VM_Name,
$VM_Path,
$VM_Switch,
$VM_StaticMac
)      

# Config Variables
$MemMaxBytes = 512MB
$MemMinBytes = 256MB
$MemStartupBytes = 512MB
$VM_Cores = 1

Import-Module BitsTransfer

Write-Output $TemplatePath, $VHDX_Path, $VM_Name, $VM_Path,$VM_Switch, $MemMaxBytes, $MemMinBytes, $MemStartupBytes, $VM_Cores, $VM_StaticMac
#Read-Host "Press Enter to continue..."
        
# Create new differencing VHDX 
#New-VHD -ParentPath $TemplatePath -Differencing -Path $VHDX_Path

# Create new participant directory
New-Item -Path $DirectoryPath -ItemType directory

#Copy Template VHDX File
#Copy-Item -Path $TemplatePath -Destination $VHDX_Path -Force

#Alternative copy method with progress bar
Start-BitsTransfer -Source $TemplatePath -Destination $VHDX_Path -Description "Copy VHDX" -DisplayName "Copying VHDX File"
             
# Create new VM and assign the new VHDX and a Virtual Switch
New-VM -VHDPath "$VHDX_Path" -Name $VM_Name -Path "$VM_Path"
         
# Configure the new VM
Set-VM -Name $VM_Name -MemoryStartupBytes $MemStartupBytes -ProcessorCount $VM_Cores
        
# Assigns a new legacy network adapter and a static Mac-Address
Add-VMNetworkAdapter -VMName "$VM_Name" -IsLegacy $true -SwitchName $VM_Switch -StaticMacAddress "$VM_StaticMac" 
Get-VMNetworkAdapter -VMName $VM_Name | Set-VMNetworkAdapter -MacAddressSpoofing On
         
#Enabling all Integration Services
Enable-VMIntegrationService -VMName $VM_Name -Name "Guest Service Interface"

# starts the new VM Clone
#Start-VM $VM_Name

        
