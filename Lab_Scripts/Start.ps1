# HEMS Startmenü

#$script_path = "C:\Users\Christian\OneDrive\Studium\Masterarbeit\mITSM\Skripte\Lab_Scripts"
$script_path = "C:\Hems-Repository\Lab_Scripts" # on MITSM_HYPERV_04

$xAppName    = "MenuDemo"
[BOOLEAN]$global:xExitSession=$false
function LoadMenuSystem(){
	[INT]$xMenu1=0
	[INT]$xMenu2=0
	[BOOLEAN]$xValidSelection=$false
	while ( $xMenu1 -lt 1 -or $xMenu1 -gt 6 ){
		CLS
		#Hauptmenü
		Write-Host "`n`t Hacking Labor Startmenü`n" 
		Write-Host "`t`tTreffen Sie eine Auswahl: `n" 
		Write-Host "`t`t`t1. Labor für alle Teilnehmer steuern" 
		Write-Host "`t`t`t2. Umgebung für einen Teilnehmer steuern " 
		Write-Host "`t`t`t3. Einzelne VMs steuern" 
		Write-Host "`t`t`t4. Laborübersicht anzeigen" 
        Write-Host "`t`t`t5. Auslastung Hyper-V ServerCore anzeigen" 
        Write-Host "`t`t`t6. Menü verlassen und zur Powershell zurückkehren`n " 
		#… Retrieve the response from the user
		[int]$xMenu1 = Read-Host "`t`tOption"
		if( $xMenu1 -lt 1 -or $xMenu1 -gt 6 ){
			Write-Host "`tSie können nur eine der aufgeführten Möglichkeiten auswählen`n" -Fore Red;start-Sleep -Seconds 1
		}
	}
	Switch ($xMenu1){    #… User has selected a valid entry.. load next menu
		1 {
			while ( $xMenu2 -lt 1 -or $xMenu2 -gt 6 ){
				CLS
				# Present the Menu Options
				Write-Host "`n`tLabor für alle Teilnehmer steuern`n" 
				Write-Host "`t`tTreffen Sie eine Auswahl`n" 
				Write-Host "`t`t`t1. Gesamtes Labor für alle Teilnehmer aufsetzen" 
				Write-Host "`t`t`t2. Gesamtes Labor zurücksetzen" 
				Write-Host "`t`t`t3. Gesamtes Labor löschen" 
				Write-Host "`t`t`t4. Gesamtes Labor herunterfahren" 
                Write-Host "`t`t`t5. Gesamtes Labor neustarten" 
                Write-Host "`t`t`t6. Hauptmenü`n" 
				[int]$xMenu2 = Read-Host "`t`tOption: "
				if( $xMenu2 -lt 1 -or $xMenu2 -gt 6 ){
					Write-Host "`tSie können nur eine der aufgeführten Optionen auswählen.`n" -Fore Red;start-Sleep -Seconds 1
				}
			}
			Switch ($xMenu2){
				1{ . $script_path\Lab-for-all-participants.ps1 }
				2{ . $script_path\Lab_zuruecksetzen.ps1 }
				3{ . $script_path\Delete-Lab.ps1 }
                4{ . $script_path\Lab_herunterfahren.ps1 }
                5{ . $script_path\Lab_neustarten.ps1 }

				default { Write-Host "`n`tHauptmenü`n" ; break}
			}
		}
		2 {
			while ( $xMenu2 -lt 1 -or $xMenu2 -gt 5 ){
				CLS
				# Present the Menu Options
				Write-Host "`n`tUmgebung für einen Teilnehmer steuern`n" 
				Write-Host "`t`tTreffen Sie eine Auswahl`n" 
				Write-Host "`t`t`t1. Umgebung (Kali, Metasploitable & Windows) für einen Teilnehmer aufsetzen" 
				Write-Host "`t`t`t2. Umgebung (Kali, Metasploitable & Windows) für einen Teilnehmer zurücksetzen" 
				Write-Host "`t`t`t3. Umgebung (Kali, Metasploitable & Windows) für einen Teilnehmer löschen" 
                Write-Host "`t`t`t4. Umgebung (Kali, Metasploitable & Windows) für einen Teilnehmer neustarten" 
				Write-Host "`t`t`t5. Hauptmenü`n" 
				[int]$xMenu2 = Read-Host "`t`tOption:"
			}
			if( $xMenu2 -lt 1 -or $xMenu2 -gt 5 ){
				Write-Host "`tSie können nur eine der aufgeführten Möglichkeiten auswählen`n" -Fore Red;start-Sleep -Seconds 1
			}
			Switch ($xMenu2){
				1{ . $script_path\Umgebung-fuer-einen-Teilnehmer-aufsetzen.ps1 }
				2{ . $script_path\Umgebung-eines-Teilnehmers-zuruecksetzen.ps1 }
				3{ . $script_path\Umgebung-eines-Teilnehmers-loeschen.ps1 }
                4{ . $script_path\Umgebung-eines-Teilnehmers-neustarten.ps1 }
				default { Write-Host "`n`tHauptmenü`n" ; break}
			}
		}
		3 {
			while ( $xMenu2 -lt 1 -or $xMenu2 -gt 10 ){
				CLS
				# Present the Menu Options
				Write-Host "`n`tEinzelne VMs steuern`n" 
				Write-Host "`t`tTreffen Sie eine Auswahl`n" 
				Write-Host "`t`t`t1. Kali-VM für Teilnehmer X aufsetzen" 
                Write-Host "`t`t`t4. Kali-VM von Teilnehmer X zurücksetzen" 
                Write-Host "`t`t`t7. Kali-VM von Teilnehmer X neustarten" 
				Write-Host "`t`t`t2. Linux (Metasploitable)-VM für Teilnehmer X aufsetzen" 
                Write-Host "`t`t`t5. Linux (Metasploitable)-VM von Teilnehmer X zurücksetzen" 
                Write-Host "`t`t`t8. Linux (Metasploitable)-VM von Teilnehmer X neustarten" 
				Write-Host "`t`t`t3. Windows-VM für Teilnehmer X aufsetzen" 
				Write-Host "`t`t`t6. Windows-VM von Teilnehmer X zurücksetzen" 
				Write-Host "`t`t`t9. Windows-VM von Teilnehmer X neustarten" 
				Write-Host "`t`t`t10. Hauptmenü`n" 
				[int]$xMenu2 = Read-Host "`t`tOption:"
				if( $xMenu2 -lt 1 -or $xMenu2 -gt 10 ){
					Write-Host "`tSie können nur eine der aufgeführten Möglichkeiten auswählen`n" -Fore Red;start-Sleep -Seconds 1
				}
			}
			Switch ($xMenu2){
				1{ Write-Host "`n`tYou Selected Option 1 – Put your Function or Action Here`n" ;start-Sleep -Seconds 3 }
				2{ Write-Host "`n`tYou Selected Option 2 – Put your Function or Action Here`n" ;start-Sleep -Seconds 3 }
				3{ Write-Host "`n`tYou Selected Option 3 – Put your Function or Action Here`n" ;start-Sleep -Seconds 3 }
                4{ Write-Host "`n`tYou Selected Option 3 – Put your Function or Action Here`n" ;start-Sleep -Seconds 3 }
                5{ Write-Host "`n`tYou Selected Option 3 – Put your Function or Action Here`n" ;start-Sleep -Seconds 3 }
                6{ Write-Host "`n`tYou Selected Option 3 – Put your Function or Action Here`n" ;start-Sleep -Seconds 3 }
                7{ Write-Host "`n`tYou Selected Option 3 – Put your Function or Action Here`n" ;start-Sleep -Seconds 3 }
                8{ Write-Host "`n`tYou Selected Option 3 – Put your Function or Action Here`n" ;start-Sleep -Seconds 3 }
                9{ Write-Host "`n`tYou Selected Option 3 – Put your Function or Action Here`n" ;start-Sleep -Seconds 3 }
				default { Write-Host "`n`tHauptmenü`n" ; break}
			}
		}
		default { $global:xExitSession=$true;break }
        
        4 { . $script_path\Laboruebersicht-anzeigen.ps1}
		5 { Write-Host "`t`t`Noch nicht implementiert"; start-sleep -seconds 5}	
	}
}
LoadMenuSystem
If ($xExitSession){
	exit    #… User quit & Exit
}else{
	. $script_path\Start.ps1    #… Loop the function
}
