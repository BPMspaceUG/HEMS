# Download and update the vm-autoconfiguration file in /etc/init.d/vm-autoconfiguration.sh

wget --no-use-server-timestamps --output-document=/etc/init.d/vm-autoconfiguration.sh  https://raw.githubusercontent.com/BPMspaceUG/HEMS/master/_Kali_Template/vm-autoconfiguration_kali.sh

sh /etc/init.d/vm-autoconfiguration.sh