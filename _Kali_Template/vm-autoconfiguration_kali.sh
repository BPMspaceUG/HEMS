#!/bin/bash

mac="`ip link show dev eth0 | grep -oE 'link/ether ([a-f0-9]{2}:){5}[a-f0-9]{2}' | cut -d' ' -f2 |tail -c3 `" # liest die MAC-Adresse aus und gibt die letzten beiden Ziffern aus.
mac_decimal=$((0x${mac})) # wandelt die HEXzahl aus der Varibalen $mac in eine Dezimalzahl um.
dec_two_digit="$(printf '%02d' "$mac_decimal")" # formatiert die DEZzahl aus mac_decimal mit führender Null. --> benötigt für den Hostnamen
vm_type=1 # VM Maschinentyp = 1 bei Kali und 2 bei Metasploitable
static_ip="$mac_decimal""$vm_type"
ifconfig eth0 10.42.42.$static_ip netmask 255.255.255.0 up
route add default gw 10.42.42.254
hostname "kali-lab""$dec_two_digit"

