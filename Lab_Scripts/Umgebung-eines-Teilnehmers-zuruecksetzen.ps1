# Allgemeine Parameter
$drive = "D:"
$childpath = "$drive\Lab\Teilnehmer_"

$script_path = "C:\Users\Christian\OneDrive\Studium\Masterarbeit\mITSM\Skripte\Lab_Scripts"
#$script_path = "C:\Lab_Scripts" # auf MITSM_HYPERV_04

#Start des Skriptes

$TN_Nr = [convert]::ToInt32((Read-Host "Für welchen Teilnehmer soll die Umgebung gelöscht werden?"), 10)
$TN_Nr = "{0:00}" -f $TN_Nr

# Zurücksetzen = löschen + neuerstellen

. $script_path\Umgebung-eines-Teilnehmers-loeschen.ps1 -TN_Nr $TN_Nr

. $script_path\Umgebung-fuer-einen-Teilnehmer-aufsetzen.ps1 -TN_Nr $TN_Nr

#Zurück zum Startmenü
. $script_path\Start.ps1