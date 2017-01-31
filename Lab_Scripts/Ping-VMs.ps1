$participant_number = Read-Host "How many participants?"

foreach ($i in 0..$participant_number) {

ping 10.42.$i.1 # Kali-VMs
ping 10.42.$i.2 #MS-VMs

}