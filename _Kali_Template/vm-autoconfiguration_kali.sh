#!/bin/bash

#stored as /etc/init.d/vm-autoconfiguration.sh
#last modified: 22.09.16 - 13:04

# gets the last two characters of the mac-address and stores it in the variable "mac"
mac="`ip link show dev eth0 | grep -oE 'link/ether ([a-f0-9]{2}:){5}[a-f0-9]{2}' | cut -d' ' -f2 |tail -c3 `" 
# transforms the HEX number from variable $mac in a decimal number .
mac_decimal=$((0x${mac}))
# formats "mac_decimal" with a guiding zero
dec_two_digit="$(printf '%02d' "$mac_decimal")" 
# stores the VM machine type; 1 = Kali, 2 = Metasploitable
vm_type=1 
# sets the static ip address according to the MAC-Address
#static_ip="$mac_decimal""$vm_type"
#ifconfig eth0 10.42.42.$static_ip netmask 255.255.255.0 up
# sets the default gateway to create an internet connection via the hems_router
#route add default gw 10.42.42.254

#edits the file /etc/network/interfaces
current_ipaddress="`sed -n '12 p' /etc/network/interfaces | cut -d ' ' -f2`"
estimated_ipaddress="10.42.$mac_decimal.1"
if [ "$current_ipaddress" = "$estimated_ipaddress" ]

then
	echo date >> /etc/init.d/vm-autoconfiguration_log.txt
	echo "$current_ipaddress" >> /etc/init.d/vm-autoconfiguration_log.txt
	
else 
	sed -i '/inet dhcp/d' /etc/network/interfaces #deletes the line where eth0 is set to dhcp
	sed -i '/iface eth0 inet static/d' /etc/network/interfaces
	sed -i '/address/d' /etc/network/interfaces #deletes old entries for address, network and gateway 
	sed -i '/broadcast/d' /etc/network/interfaces
	sed -i '/netmask/d' /etc/network/interfaces
	sed -i '/gateway/d' /etc/network/interfaces
	# sets the new static  ip configuration for eth0
	echo "iface eth0 inet static" >> /etc/network/interfaces
	echo "address 10.42.$mac_decimal.1">> /etc/network/interfaces
	#echo "broadcast 10.42.254.254" >> /etc/network/interfaces
	echo "netmask 255.255.0.0" >> /etc/network/interfaces
	echo "gateway 10.42.254.254" >> /etc/network/interfaces

	sleep 1
	sudo /etc/init.d/networking restart
	sleep 1
	echo date >> /etc/init.d/vm-autoconfiguration_log.txt
	echo "Ip Address successfully changed to $estimated_ipaddress">> /etc/init.d/vm-autoconfiguration_log.txt

fi


#Changes the hostname in /etc/hosts and /etc/hostname
current_hostname="`hostname`"
estimated_hostname="kali-lab$dec_two_digit"
if [ "$current_hostname" = "$estimated_hostname" ]

then
	echo date >> /etc/init.d/vm-autoconfiguration_log.txt
	echo "$current_hostname" >> /etc/init.d/vm-autoconfiguration_log.txt
else 

	#hostname "kali-lab""$dec_two_digit"
	sudo chmod 777 /etc/hosts 
	sudo chmod 777 /etc/hostname
	echo "kali-lab""$dec_two_digit" > /etc/hostname
	#sed -i '/127.0.1.1/d' /etc/hosts
	sleep 1
	#echo "127.0.1.1  kali-lab""$dec_two_digit" >> /etc/hosts
	echo "127.0.0.1 localhost"  > /etc/hosts
	echo "127.0.1.1 kali-lab$dec_two_digit" >> /etc/hosts
	sudo chmod 644 /etc/hosts
	sudo chmod 644 /etc/hostname    
	sleep 1
	# restarts the ssh service with the new settings
	service sshd restart

	echo date >> /etc/init.d/vm-autoconfiguration_log.txt
	echo "hostname successfully changed to $estimated_hostname" >> /etc/init.d/vm-autoconfiguration_log.txt
	echo "VM wird in 5 Sekunden neugestartet"
	sleep 5
	sudo reboot -f
fi
