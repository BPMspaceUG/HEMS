#!/bin/bash
# Download and update the vm-autoconfiguration file in /etc/init.d/vm-autoconfiguration.sh

wget -q --spider http://google.com

if [ $? -eq 0 ]; then
	date >> /etc/init.d/wget_log.txt
    echo "Online -> Download erfolgreich" >> /etc/init.d/wget_log.txt
    wget --no-check-certificate --output-document=/etc/init.d/vm-autoconfiguration.sh  https://raw.githubusercontent.com/BPMspaceUG/HEMS/master/_Metasploitable_Template/vm-autoconfiguration_metasploitable.sh

else
	date >> /etc/init.d/wget_log.txt
    echo "Offline -> Download gescheitert" >> /etc/init.d/wget_log.txt
fi

echo "Autoconfiguration is now executed"
sleep 5

sudo sh /etc/init.d/vm-autoconfiguration.sh