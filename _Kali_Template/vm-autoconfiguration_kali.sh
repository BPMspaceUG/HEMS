#!/bin/bash

#stored as /etc/init.d/vm-autoconfiguration.sh
#last modified: 17.10.16 - 16:40
 
# gets the last two characters of the mac-address and stores it in the variable "tail_current_mac"
tail_current_mac="`ip link show dev eth0 | grep -oE 'link/ether ([a-f0-9]{2}:){5}[a-f0-9]{2}' | cut -d' ' -f2 |tail -c3 `" 
# transforms the HEX number from variable $tail_current_mac in a decimal number .
tail_current_mac_dec=$((0x${tail_current_mac}))
# formats "mac_decimal" with a guiding zero
dec_two_digit="$(printf '%02d' "$tail_current_mac_dec")" 
# stores the VM machine type; 1 = Kali, 2 = Metasploitable



# Definition of all necessary parameters
vm_type=1 #VM Types: Kali = 1, Metasploitable Linux = 2, Windows = 3
orga=42
static_ip="10.$orga.$tail_current_mac_dec.$vm_type"
broadcast="10.$orga.255.255"
netmask="255.255.0.0"
gateway="10.$orga.254.254"
vm_hostname="kali-lab$dec_two_digit"



#edits the file /etc/network/interfaces
current_ipaddress="`sed -n '13 p' /etc/network/interfaces | cut -d ' ' -f2`"
#estimated_ipaddress="10.42.$mac_decimal.$vm_type"
if [ "$current_ipaddress" = "$static_ip" ]

then
	echo date >> /etc/init.d/vm-autoconfiguration_log.txt
	echo "$current_ipaddress" >> /etc/init.d/vm-autoconfiguration_log.txt
	
else 
	#sed -i '/inet dhcp/d' /etc/network/interfaces #deletes the line where eth0 is set to dhcp
	#sed -i '/iface eth0 inet static/d' /etc/network/interfaces
	#sed -i '/address/d' /etc/network/interfaces #deletes old entries for address, network and gateway 
	#sed -i '/broadcast/d' /etc/network/interfaces
	#sed -i '/netmask/d' /etc/network/interfaces
	#sed -i '/gateway/d' /etc/network/interfaces
	# sets the new static  ip configuration for eth0
	#echo "iface eth0 inet static" >> /etc/network/interfaces
	#echo "address $static_ip">> /etc/network/interfaces
	#echo "broadcast $broadcast" >> /etc/network/interfaces
	#echo "netmask $netmask" >> /etc/network/interfaces
	#echo "gateway $gateway" >> /etc/network/interfaces

	#This method writes the IP Parameters into a blank copy of the interfaces file and overwrites the old one.
	# Therefore "sed" isn't necessary anymore
	# Interfaces_empty must exist

	#wget --output-document=/etc/network/interfaces_empty  https://raw.githubusercontent.com/BPMspaceUG/HEMS/master/_Kali_Template/interfaces_empty

	echo "address $static_ip">> /etc/network/interfaces_default
	echo "broadcast $broadcast" >> /etc/network/interfaces_default
	echo "netmask $netmask" >> /etc/network/interfaces_default
	echo "gateway $gateway" >> /etc/network/interfaces_default
	echo "#interfaces_default copy" >> /etc/network/interfaces_default
	sudo cp /etc/network/interfaces /etc/network/interfaces_backup #backups the old interfaces file
	sudo cp /etc/network/interfaces_default /etc/network/interfaces #copies the new generated interfaces file

	sleep 1
	sudo /etc/init.d/networking restart
	sleep 1
	echo date >> /etc/init.d/vm-autoconfiguration_log.txt
	echo "Ip Address successfully changed to $static_ip">> /etc/init.d/vm-autoconfiguration_log.txt

fi


#Changes the hostname in /etc/hosts and /etc/hostname
current_hostname="`hostname`"
if [ "$current_hostname" = "$vm_hostname" ]

then
	echo date >> /etc/init.d/vm-autoconfiguration_log.txt
	echo "$current_hostname" >> /etc/init.d/vm-autoconfiguration_log.txt
else 

	#hostname "kali-lab""$dec_two_digit"
	sudo chmod 777 /etc/hosts 
	sudo chmod 777 /etc/hostname
	echo "$vm_hostname" > /etc/hostname
	#sed -i '/127.0.1.1/d' /etc/hosts
	sleep 1
	#echo "127.0.1.1  kali-lab""$dec_two_digit" >> /etc/hosts
	echo "127.0.0.1 localhost" > /etc/hosts
	echo "127.0.1.1 $vm_hostname" >> /etc/hosts
	sudo chmod 644 /etc/hosts
	sudo chmod 644 /etc/hostname    
	sleep 1
	# restarts the ssh service with the new settings
	service sshd restart

	echo date >> /etc/init.d/vm-autoconfiguration_log.txt
	echo "hostname successfully changed to $vm_hostname" >> /etc/init.d/vm-autoconfiguration_log.txt
	echo "VM restarts in 5 seconds"
	sleep 5
	sudo reboot -f
fi
