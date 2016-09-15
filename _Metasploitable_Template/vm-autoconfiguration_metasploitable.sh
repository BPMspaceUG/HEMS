#!/bin/bash

#stored as /etc/init.d/vm-autoconfiguration.sh
#Permisson to execute the script at startup can be found at /etc/sudoers

# gets the last two characters of the mac-address and stores it in the variable "mac"
mac="`ip link show dev eth0 | grep -oE 'link/ether ([a-f0-9]{2}:){5}[a-f0-9]{2}' | cut -d' ' -f2 |tail -c3 `" 
# transforms the HEX number from variable $mac in a decimal number .
mac_decimal=$((0x${mac})) 
# formats "mac_decimal" with a guiding zero
dec_two_digit="$(printf '%02d' "$mac_decimal")" 
# stores the VM machine type; 1 = Kali, 2 = Metasploitable
vm_type=2 
static_ip="$mac_decimal""$vm_type"
# sets the static ip address according to the MAC-Address
sudo ifconfig eth0 10.42.42.$static_ip netmask 255.255.255.0 up 
# sets the default gateway to create an internet connection via the hems_router
sudo route add default gw 10.42.42.254 

#Changes the hostname an overrites it in /etc/hosts and /etc/hostname
# changes file permissons of /etc/hosts and /etc/hostname
sudo chmod 777 /etc/hosts 
sudo chmod 777 /etc/hostname
# sets the hostname
sudo hostname "linux-lab""$dec_two_digit" 
echo "linux-lab""$dec_two_digit" > /etc/hostname
echo -e "127.0.0.1  localhost\n127.0.1.1  linux-lab""$dec_two_digit" > /etc/hosts
# changes back file permissons of /etc/hosts and /etc/hostname
sudo chmod 644 /etc/hosts
sudo chmod 644 /etc/hostname


