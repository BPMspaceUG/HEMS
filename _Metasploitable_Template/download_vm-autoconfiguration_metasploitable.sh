# Download and update the vm-autoconfiguration file in /etc/init.d/vm-autoconfiguration.sh

wget --no-check-certificate --output-document=/etc/init.d/vm-autoconfiguration.sh  https://raw.githubusercontent.com/BPMspaceUG/HEMS/master/_Metasploitable_Template/vm-autoconfiguration_metasploitable.sh

sudo sh /etc/init.d/vm-autoconfiguration.sh