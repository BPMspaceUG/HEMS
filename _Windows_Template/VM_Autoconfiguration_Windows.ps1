Write-Output "Die automatische VM - Konfiguration wird in 10 Sekunden ausgeführt"

    foreach ($i in 10..1){
    Write-Output "$i"
    Start-Sleep -Seconds 1
       }


Write-Output "MAC-Adresse wird ausgelesen..."
$Mac = get-wmiobject win32_networkadapter | where {$_.Name -like “Microsoft Hyper-V Network Adapter #*”} | select MACAddress | format-wide | out-string
Write-Output "Die MAC - Adresse lautet: $Mac"
$lastCharMac = $Mac.remove(0,19).remove(2.0)
#Write-Output $lastCharMac
$lastCharMac = [convert]::ToInt64($lastCharMac, 16)
$lastCharMac = "{0:X2}" -f $lastCharMac
$lastCharMacInt = [convert]::ToInt32($lastCharMac, 16)
$lastCharMacInt = "{0:00}" -f $lastCharMacInt
#Write-Output $lastCharMac, $lastCharMacInt


#Änderung der IP-Adresskonfiguration
$vmtype = "3" #IP Adressen von Windows VMS enden auf 3
$ip = "$lastCharMacInt$vmtype"
$ip = [convert]::ToInt32($ip, 10)
Write-Output "IP-Adresse wird überprüft"
if (Get-WmiObject Win32_NetworkadapterConfiguration | where {$_.IPAddress -eq "10.42.42.$ip"}){
Write-Output "IP-Adresse ist 10.42.42.$ip. So soll es sein"
}
else {
$ipconfiguration = Get-WmiObject Win32_NetworkadapterConfiguration | where {$_.Description -like "Microsoft Hyper-V Network Adapter #*"}
$vmtype = "3" #IP Adressen von Windows VMS enden auf 3
$ip = "$lastCharMacInt$vmtype"
$ip = [convert]::ToInt32($ip, 10)

[array]$staticip = "10.42.42.$ip"
[array]$gateway ="10.42.42.254"
[array]$subnet ="255.255.255.0"
[array]$dns = "192.168.178.1","8.8.8.8"

$ipconfiguration.EnableStatic($staticip, $subnet)
$ipconfiguration.setGateways($gateway, 1)
$ipconfiguration.SetDNSServerSearchOrder($dns)
Write-Output "Die neue IP-Adresse lautet: $staticip"
}

#Änderung des Hostnamens
Write-Output "Hostname wird überprüft..."
if (Get-WmiObject -Class Win32_ComputerSystem | where {$_.Name -like "windows-lab$lastCharMacInt"}) {
    Write-Output "Hostname ist windows-lab$lastCharMacInt. So soll es sein" 
}
else {
Write-Output "Hostname wird geändert: windows-lab$lastCharMacInt"
Rename-Computer -NewName "windows-lab$lastCharMacInt"

Write-Output "Ein Neustart wird in 10 Sekunden durchgeführt"

    foreach ($i in 10..1){
    Write-Output "$i"
    Start-Sleep -Seconds 1
       }

shutdown -r -t 0
}

Write-Output "Hostname: windows-lab$lastCharMacInt"
Write-Output "IP-Adresse: 10.42.42.$ip"