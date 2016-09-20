# Download and update the vm-autoconfiguration file in /etc/init.d/vm-autoconfiguration.sh

wget --output-document=/etc/init.d/vm-autoconfiguration.sh  https://raw.githubusercontent.com/BPMspaceUG/HEMS/master/_Kali_Template/vm-autoconfiguration_kali.sh

echo "Autoconfiguration is now executed"
sleep 5

sh /etc/init.d/vm-autoconfiguration.sh