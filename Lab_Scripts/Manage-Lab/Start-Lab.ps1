# Komplettes Lab starten

$script_path = "C:\Hems-Repository\Lab_Scripts"

Start-VM kali.lab*
Start-VM linux.lab*
Start-VM windows.lab*
Start-VM winserver.lab*

#Zurück zum Startmenü
. $script_path\Start.ps1