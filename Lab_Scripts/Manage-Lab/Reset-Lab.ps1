# General parameters
$drive = "D:"
$childpath = "$drive\Lab\Teilnehmer_"

#$script_path = "C:\Users\Christian\OneDrive\Studium\Masterarbeit\mITSM\Skripte\Lab_Scripts"
$script_path = "C:\HEMS-Repository\Lab_Scripts" # auf MITSM_HYPERV_04


# Get Number of VMs

$VMs = Get-VM "*-lab*"
$VM_count = $VMs.count
# get number of participants
$participant_number = ($VM_count / 3) - 1 # because the trainer is no participant

# Delete Lab and create it again
. $script_path\Manage-Lab\Delete-Lab.ps1 -participant_number $participant_number