﻿param (
[string]$TN_Nr
)


# Allgemeine Parameter
$drive = "D:"
$templatepath = "$drive\VM-Templates\"
$childpath = "$drive\Lab\Teilnehmer_"
$vSwitchName = "Lab_Switch"
$script_path = "C:\Lab_Scripts" # auf MITSM_HYPERV_04

#Variablen für Kali Linux Template

$Kali_BaseVHD = "Kali_Training\Kali_Training.vhdx"
$Kali_MAC = "00155DB20A"


#Variablen für Metasploitable Template

$MS_BaseVHD = "Metasploitable_Training\Metasploitable_Training.vhdx"
$MS_MAC = "00155DB20B"

#Variablen für Windows Template

$Win_BaseVHD = "Windows_Training\Windows_Training.vhdx"
$Win_MAC = "00155DB20C"

# VM Parameter --> funktioniert noch nicht --> TODO
$Cores = 4
$StartupBytes = 1024MB
$MemoryMinBytes = 512MB
$MemoryMaxBytes = 2048MB


#Start des Skriptes

# Schreibschutz auf die Templates setzen, wenn noch nicht geschehen
. $script_path\TemplateVHD-Schreibschutz-setzen.ps1

#Abfrage der Teilnehmeranzahl

if (!$TN_Nr) { 
$TN_Nr = [convert]::ToInt32((Read-Host "Geben Sie die Nummer des Teilnehmers ein, für den sie die Umgebung erstellen wollen"), 10)
#$VMAnzahl = $Anzahl * 3
$TN_Nr = "{0:00}" -f $TN_Nr
}

#Write-Output "Es werden $Anzahl Teilnehmer am Kurs teilnehmen."
#$VMAnzahl = [convert]::ToInt32($Anzahl) * 3
Write-Output "Es werden nun 3 virtuelle Maschinen für Teilnehmer $TN_Nr  erstellt."
#Write-Output "$HexAnzahl"

Write-Output "--------------------------------------------------------------------------------"
Start-Sleep -Seconds 3


   #Write-Output "$Anzahl"
   
    $TN_Nr = [convert]::ToInt32($TN_Nr, 10)
    $TN_Nr = "{0:00}" -f $TN_Nr

   #Write-Output "$TN_Nr"
 



############Anlegen der Kali VM

#Zusammensetzen des VM-Namens:
$Kali_VMName="kali.lab$TN_Nr.net"

#Pfad zum neuen Teilnehmerordner
$VHDXfilename = "$childpath$TN_Nr\$Kali_VMName\$Kali_VMName.VHDX"
 
# Erstellen der neuen VHD   
New-VHD -ParentPath "$templatepath$Kali_BaseVHD" -Differencing -Path "$VHDXfilename"
 
#Erstellen der neuen VM; Verbindung mit dem Switch herstellen
New-VM -VHDPath "$VHDXfilename" -Name "$Kali_VMName" -Path "$childpath$TN_Nr" -SwitchName "$vSwitchName"
 
# Konfigurieren der VM mit den oben genannten VM Parametern
Set-VM -Name "$Kali_VMName" -DynamicMemory -MemoryMaximumBytes 2GB -MemoryMinimumBytes 512MB -MemoryStartupBytes 1GB -ProcessorCount 4


# Zuweisen der statischen MAC - Adresse
$Hex_i = [convert]::ToInt32($TN_Nr, 10)
$Hex_i = "{0:X2}" -f $Hex_i
#Add-VMNetworkAdapter -VMName "$Kali_VMName" -StaticMacAddress "$Kali_MAC$Hex_i" -SwitchName $vSwitchName
get-vm -name "$Kali_VMName" | Get-VMNetworkAdapter | Set-VMNetworkAdapter -StaticMacAddress "$Kali_MAC$Hex_i"

#Aktivieren der Integrationsdienste
Enable-VMIntegrationService -VMName "$Kali_VMName" -Name "Guest Service Interface"

    
Write-Output "$Kali_VMName angelegt"
Write-Output "Die MAC-Adresse lautet: $Kali_MAC$Hex_i"
Start-VM "$Kali_VMName"   





############ Anlegen der Metasploitable VM

#Zusammensetzen des VM-Namens:
$MS_VMName="linux.lab$TN_Nr.net"

#Pfad zum neuen Teilnehmerordner
$VHDXfilename = "$childpath$TN_Nr\$MS_VMName\$MS_VMName.VHDX"
 
# Erstellen der neuen VHD   
New-VHD -ParentPath "$templatepath$MS_BaseVHD" -Differencing -Path "$VHDXfilename"
 
#Erstellen der neuen VM
New-VM -VHDPath "$VHDXfilename" -Name "$MS_VMName" -Path "$childpath$TN_Nr" #-SwitchName "$vSwitchName"
 
# Konfigurieren der VM mit den oben genannten VM Parametern
Set-VM -Name "$MS_VMName" -DynamicMemory -MemoryMaximumBytes 1GB -MemoryMinimumBytes 256MB -MemoryStartupBytes 512MB -ProcessorCount 4

# Hinzufügen des Netzwerkadapters mit statischer MAC - Adresse    
$Hex_i = [convert]::ToInt32($TN_Nr, 10)
$Hex_i = "{0:X2}" -f $Hex_i
Add-VMNetworkAdapter -VMName "$MS_VMName" -IsLegacy $true -StaticMacAddress "$MS_MAC$Hex_i" -SwitchName $vSwitchName

#get-vm -name "$MS_VMName" | Get-VMNetworkAdapter | Set-VMNetworkAdapter -StaticMacAddress "$MS_MAC$Hex_i"

#Aktivieren der Integrationsdienste
Enable-VMIntegrationService -VMName "$MS_VMName" -Name "Guest Service Interface"
    
Write-Output "$MS_VMName angelegt"
Write-Output "Die MAC-Adresse lautet: $MS_MAC$Hex_i"
Start-VM "$MS_VMName"






############ Anlegen der Windows VM

#Zusammensetzen des VM-Namens:
$Win_VMName="windows.lab$TN_Nr.net"

#Pfad zum neuen Teilnehmerordner
$VHDXfilename = "$childpath$TN_Nr\$Win_VMName\$Win_VMName.VHDX"

# Erstellen der neuen VHD   
New-VHD -ParentPath "$templatepath$Win_BaseVHD" -Differencing -Path "$VHDXfilename"
 
#Erstellen der neuen VM; Verbindung mit dem Switch herstellen
New-VM -VHDPath "$VHDXfilename" -Name "$Win_VMName" -Path "$childpath$TN_Nr" -SwitchName "$vSwitchName"
 
# Konfigurieren der VM mit den oben genannten VM Parametern
Set-VM -Name "$Win_VMName" -DynamicMemory -MemoryMaximumBytes 2GB -MemoryMinimumBytes 512MB -MemoryStartupBytes 1GB -ProcessorCount 4

# Zuweisen der statischen MAC - Adresse      
$Hex_i = [convert]::ToInt32($TN_Nr, 10)
$Hex_i = "{0:X2}" -f $Hex_i
#Add-VMNetworkAdapter -VMName $Win_VMName -StaticMacAddress "$Win_MAC$Hex_i" -SwitchName $vSwitchName
get-vm -name "$Win_VMName" | Get-VMNetworkAdapter | Set-VMNetworkAdapter -StaticMacAddress "$Win_MAC$Hex_i"

#Aktivieren der Integrationsdienste
Enable-VMIntegrationService -VMName "$Win_VMName" -Name "Guest Service Interface" 
    
Write-Output "$Win_VMName angelegt"
Write-Output "Die MAC-Adresse lautet: $Win_MAC$Hex_i"
Start-VM "$Win_VMName"


Write-Output "-------------------------------------------------------------------------------------------"
Start-Sleep -Seconds 5
    
Write-Output "3 VMs für Teilnehmer $TN_Nr erfolgreich erstellt"


#Zurück zum Startmenü
. $script_path\Start.ps1