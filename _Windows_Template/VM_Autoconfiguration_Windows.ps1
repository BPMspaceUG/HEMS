#stored as c:\vm_autoconfiguration.ps1
#last modified: 23.09.16 - 13:21

Write-Output "The automatic VM Selfconfiguration starts in 5 seconds"

    foreach ($i in 5..1){
    Write-Output "$i"
    Start-Sleep -Seconds 1
       }

# Fetches the last two Characters of the MAC - Address
Write-Output "MAC-Adresse wird ausgelesen..."
$Current_Mac = get-wmiobject win32_networkadapter | where {$_.Name -like “Microsoft Hyper-V Network Adapter #*”} | select MACAddress | format-wide | out-string
Write-Output "Die MAC - Adresse lautet: $Current_Mac"
$tail_current_Mac = $Current_Mac.remove(0,19).remove(2.0) # selects only the last two characters of the current MAC - Address
#Let's do some type conversion
$tail_current_Mac = [convert]::ToInt64($tail_current_Mac, 16)
$tail_current_Mac = "{0:X2}" -f $tail_current_Mac
$tail_current_Mac_Dec = [convert]::ToInt32($tail_current_Mac, 16)
$tail_current_Mac_Dec = "{0:00}" -f $tail_current_Mac_Dec

$ip_sequential = "$tail_current_Mac_Dec"
$ip_sequential = [convert]::ToInt32($ip_sequential, 10)



# Definition of all necessary variables
$vm_type = 3 #VM Types: Kali = 1, Metasploitable Linux = 2, Windows = 3
$orga = 42
[array]$static_ip = "10.$orga.$ip_sequential.$vm_type"
[array]$gateway ="10.$orga.254.254"
[array]$subnet ="255.255.0.0"
[array]$dns = "192.168.178.1","8.8.8.8"
$vm_hostname = "windows-lab$tail_current_Mac_Dec"

 

#Changes the IP Configuration

Write-Output "IP Address will be checked "
if (Get-WmiObject Win32_NetworkadapterConfiguration | where {$_.IPAddress -eq "$static_ip"})
    {
    Write-Output "IP-Adresse is $static_ip."
    }
else {
    $ipconfiguration = Get-WmiObject Win32_NetworkadapterConfiguration | where {$_.Description -like "Microsoft Hyper-V Network Adapter #*"}
    #$vm_type = 3 #IP Adressen von Windows VMS enden auf 3
    #$ip = "$tail_current_Mac_Dec"
    #$ip = [convert]::ToInt32($ip, 10)
    $ipconfiguration.EnableStatic($static_ip,$subnet)
    $ipconfiguration.setGateways($gateway, 1)
    $ipconfiguration.SetDNSServerSearchOrder($dns)
    Write-Output "The IP - Address is now: $static_ip"
    }

#Changes the VM hostname
Write-Output "Hostname will be checked"
if (Get-WmiObject -Class Win32_ComputerSystem | where {$_.Name -like "$vm_hostname"}) 
    {
        Write-Output "Hostname is $vm_hostname." 
    }
else {
    Write-Output "Hostname will be changed: $vm_hostname"
    Rename-Computer -NewName "$vm_hostname"

    Write-Output "The VM restarts in 5 seconds"

        foreach ($i in 5..1){
        Write-Output "$i"
        Start-Sleep -Seconds 1
           }

    shutdown -r -t 0
    }

Write-Output "Hostname: $vm_hostname"
Write-Output "IP-Adresse: $static_ip"