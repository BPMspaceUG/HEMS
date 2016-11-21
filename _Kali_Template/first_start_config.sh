# first install script
# Updates the system
apt-get update && upgrade
#install the SSH Server and configures it
apt-get install openssh-server
Update-rc.d -f ssh remove
Update-rc.d -f ssh defaults # sets default ssh start options
# download ssh config file
# wget
# installation of x-server for rdp
Apt-get install xrdp
Apt-get install tightvncserver 

# download local.autostart file to /etc/init.d

	chmod 755 /etc/init.d/local.autostart
	update-rc.d local.autostart defaults
