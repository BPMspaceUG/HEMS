# Allgemeine Parameter
$drive = "D:"
$templatepath = "$drive\VM-Templates\"
$childpath = "$drive\Lab\Teilnehmer_"
$vSwitchName = "Lab_Switch"

#Variablen für Windows Template

$Win_BaseVHD = "Windows_Training\Windows_Training.vhdx"
$Win_MAC = "00155DB20C"

# VM Parameter
$Cores = 4
$StartupBytes = 1024MB
$MemoryMinBytes = 512MB
$MemoryMaxBytes = 2048MB


#Start des Skriptes

$TN_Nr = [convert]::ToInt32((Read-Host "Geben Sie die Nummer des Teilnehmers ein, für den sie eine neue Windows - VM erstellen wollen"), 10)
#$VMAnzahl = $Anzahl * 3
$TN_Nr = "{0:00}" -f $TN_Nr

#Write-Output "Es werden $Anzahl Teilnehmer am Kurs teilnehmen."
#$VMAnzahl = [convert]::ToInt32($Anzahl) * 3
Write-Output "Es wird nun eine neue Windows VM für Teilnehmer $TN_Nr  erstellt."
#Write-Output "$HexAnzahl"

Write-Output "--------------------------------------------------------------------------------"
Start-Sleep -Seconds 3


   #Write-Output "$Anzahl"
   
    $TN_Nr = [convert]::ToInt32($TN_Nr, 10)
    $TN_Nr = "{0:00}" -f $TN_Nr

   #Write-Output "$TN_Nr"
 


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
Set-VM -Name "$Win_VMName" -DynamicMemory -MemoryMaximumBytes 2GB -MemoryMinimumBytes 512MB -MemoryStartupBytes 1GB -ProcessorCount 2

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
    
Write-Output "Windows VM für Teilnehmer $TN_Nr erfolgreich erstellt"
