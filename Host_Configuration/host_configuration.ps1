## Configuration Script for a PC or a (core) server running HYPER-V
# Attention: Only run it on the following systems:
# Windows 8 and above
# Windows Server 2012 R2 and above
# Windows Hyper-V Core Server 2012 and above
# Some Command-Lets will cause an error on older systems, because they are not implemented

# Some variable definitions
$new_hostname = Read-Host "Please enter the new hostname of this HYPER-V Machine"
[array]$ip_address = Read-Host "Please enter the new IP Address"
[array]$mask_bits = Read-Host "Please enter the PrefixLength according to your preferred subnet mask"
[array]$gateway = Read-Host "Please enter the new Gateway Address"
[array]$dns = Read-Host "Please enter the relevant DNS - Servers. Seperate them with a comma."


# First, let's configrue RDP Connections
$current_hostname = $env:computername
$rdp_call = Get-WmiObject -Namespace "root\cimv2\TerminalServices" -Class win32_terminalservicesetting -ComputerName $current_hostname #| select ServerName, AllowTSConnections
$rdp_call.setAllowTSConnections(1,1)
$rdp_status = $rdp_call | Select ServerName, AllowTSConnections | format-list

Write-Output "$rdp_status"

# Now, lets configure our firewall for complete remote management

netsh advfirewall firewall set rule group="Remotedesktop" new enable=yes
start-sleep 1
netsh advfirewall firewall set rule group="Windows-Remoteverwaltung" new enable=yes
start-sleep 1
netsh advfirewall firewall set rule group="Datei- und Druckerfreigabe" new enable=yes
start-sleep 1
netsh advfirewall firewall set rule group="Remotedienstverwaltung" new enable=yes
start-sleep 1 
netsh advfirewall firewall set rule group="Leistungsprotokolle und -warnungen" new enable=yes
start-sleep 1 
Netsh advfirewall firewall set rule group="Remote-Ereignisprotokollverwaltung" new enable=yes
start-sleep 1
Netsh advfirewall firewall set rule group="Remoteverwaltung geplanter Aufgaben" new enable=yes
start-sleep 1 
netsh advfirewall firewall set rule group="Remotevolumeverwaltung" new enable=yes
start-sleep 1
netsh advfirewall firewall set rule group="Windows-Firewallremoteverwaltung" new enable=yes
start-sleep 1
netsh advfirewall firewall set rule group="Windows-Verwaltungsinstrumentation (WMI)" new enable=yes
start-sleep 1

#Allow ping requests
netsh advfirewall firewall set rule profile=Domain name="Datei- und Druckerfreigabe (Echoanforderung - ICMPv4 eingehend)" new enable=yes
start-sleep 1

# download and install GIT

# configure git and clone the HEMS Repository

# set new hostname
Rename-Computer -NewName "$new_hostname"

# Change the IP Configuration
$active_NIC =  Get-NetAdapter | ? {$_.Status -eq “up”}
# Remove any existing IP, gateway from our ipv4 adapter
If (($active_NIC | Get-NetIPConfiguration).IPv4Address.IPAddress) {
    $active_NIC | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
}

If (($active_NIC | Get-NetIPConfiguration).Ipv4DefaultGateway) {
    $active_NIC | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
}

$active_NIC | New-NetIPAddress `
    -AddressFamily "IPv4" `
    -IPAddress $ip_address `
    -PrefixLength $mask_bits `
    -DefaultGateway $gateway

# Configure the DNS server IP addresses
$active_NIC | Set-DnsClientServerAddress -ServerAddresses $dns

Write-Outpu "After all, the machine performs a reboot to complete the configuration task. Be sure that you remember the new IP Address: $ip_address"
start-sleep 2
Write-Output "The Machine will do a reboot in 5 Seconds"
    foreach ($i in 5..1){
    Write-Output "$i"
    Start-Sleep -Seconds 1
       }
shutdown -r -t 0