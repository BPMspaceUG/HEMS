#!/bin/bash

#stored as /etc/init.d/vm-autoconfiguration.sh
#last modified: 22.11.2016 - 17:09
 
#. gets the last two characters of the mac-address and stores it in the variable "tail_current_mac".
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
	
	sudo cp /etc/network/interfaces_default /etc/network/interfaces_default_copy
	echo "address $static_ip">> /etc/network/interfaces_default_copy
	echo "broadcast $broadcast" >> /etc/network/interfaces_default_copy
	echo "netmask $netmask" >> /etc/network/interfaces_default_copy
	echo "gateway $gateway" >> /etc/network/interfaces_default_copy
	sudo cp /etc/network/interfaces /etc/network/interfaces_backup #backups the old interfaces file
	sudo mv /etc/network/interfaces_default_copy /etc/network/interfaces #moves the new generated interfaces file over the old one

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

#Re-Register Nessus Installation
sudo /etc/init.d/nessusd start
sudo /etc/init.d/nessusd stop
sleep 5
yes | sudo /opt/nessus/sbin/nessuscli fix --reset
sudo /opt/nessus/sbin/nessuscli fetch --register-offline /opt/nessus/etc/nessus/nessus_licenses/nessus$dec_two_digit.license
sudo /etc/init.d/nessusd start
sleep 5


#EOF


