#!/bin/bash

#stored as /etc/init.d/vm-autoconfiguration.sh
#last modified: 20.09.2016 - 13:43

# gets the last two characters of the mac-address and stores it in the variable "mac"
mac="`ip link show dev eth0 | grep -oE 'link/ether ([a-f0-9]{2}:){5}[a-f0-9]{2}' | cut -d' ' -f2 |tail -c3 `" 
# transforms the HEX number from variable $mac in a decimal number .
mac_decimal=$((0x${mac}))
# formats "mac_decimal" with a guiding zero
dec_two_digit="$(printf '%02d' "$mac_decimal")" 
# stores the VM machine type; 1 = Kali, 2 = Metasploitable
vm_type=1 
# sets the static ip address according to the MAC-Address
static_ip="$mac_decimal""$vm_type"
#ifconfig eth0 10.42.42.$static_ip netmask 255.255.255.0 up
# sets the default gateway to create an internet connection via the hems_router
#route add default gw 10.42.42.254

#edits the file /etc/network/interfaces
sed -i '/inet dhcp/d' /etc/network/interfaces #deletes the line where eth0 is set to dhcp
# sets eth0 to static configuration
echo "iface eth0 inet static" >> /etc/network/interfaces
echo "address 10.42.42.$static_ip">> /etc/network/interfaces
echo "netmask 255.255.255.0" >> /etc/network/interfaces
echo "gateway 10.42.42.254" >> /etc/network/interfaces
ifdown eth0
ifup eth0
/etc/init.d/networking restart

#Changes the hostname in /etc/hosts and /etc/hostname
hostname "kali-lab""$dec_two_digit"
echo "kali-lab""$dec_two_digit" > /etc/hostname
sed -i 2D /etc/hosts
echo "127.0.1.1  kali-lab""$dec_two_digit" >> /etc/hosts    

