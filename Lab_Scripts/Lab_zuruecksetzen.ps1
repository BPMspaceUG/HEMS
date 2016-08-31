# Allgemeine Parameter
$drive = "D:"
$childpath = "$drive\Lab\Teilnehmer_"

#$script_path = "C:\Users\Christian\OneDrive\Studium\Masterarbeit\mITSM\Skripte\Lab_Scripts"
$script_path = "C:\Lab_Scripts" # auf MITSM_HYPERV_04


# Anzahl der angelegten VMs ermitteln

$VMs = Get-VM
$VMAnzahl = $VMs.count
$TN_VM = $VMAnzahl - 3
$TNAnzahl = $TN_VM / 3

# Lab löschen
. $script_path\Lab_loeschen.ps1

# Lab neuaufsetzen
. $script_path\Lab-fuer-alle-Teilnehmer-aufsetzen.ps1 -TNAnzahl $TNAnzahl

#Zurück zum Startmenü
. $script_path\Start.ps1