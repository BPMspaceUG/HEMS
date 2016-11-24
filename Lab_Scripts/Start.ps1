# HEMS Startmenü

#$script_path = "C:\Users\Christian\OneDrive\Studium\Masterarbeit\mITSM\Skripte\Lab_Scripts"
$script_path = "C:\Hems-Repository\Lab_Scripts" # on MITSM_HYPERV_04

$xAppName    = "MenuDemo"
[BOOLEAN]$global:xExitSession=$false
function LoadMenuSystem(){
	[INT]$xMenu1=0
	[INT]$xMenu2=0
	[BOOLEAN]$xValidSelection=$false
	while ( $xMenu1 -lt 1 -or $xMenu1 -gt 8 ){
		#CLS
		#Hauptmenü
		Write-Host "`n`t Hacking Lab Startmenü`n" 
		Write-Host "`t`tTreffen Sie eine Auswahl: `n" 
		Write-Host "`t`t`t1. Labor verwalten" 
		Write-Host "`t`t`t2. Umgebung einzelner Teilnehmer verwalten "
        Write-Host "`t`t`t3. VM Typen verwalten " 
		Write-Host "`t`t`t4. Einzelne VMs verwalten" 
		Write-Host "`t`t`t5. Laborübersicht anzeigen" 
        Write-Host "`t`t`t6. Auslastung Hyper-V ServerCore anzeigen"
        Write-Host "`t`t`t7. Update lokales Git Repository" 
        Write-Host "`t`t`t8. Menü verlassen und zur Powershell zurückkehren`n " 
		#… Retrieve the response from the user
		[int]$xMenu1 = Read-Host "`t`tOption"
		if( $xMenu1 -lt 1 -or $xMenu1 -gt 8 ){
			Write-Host "`tSie können nur eine der aufgeführten Möglichkeiten auswählen`n" -Fore Red;start-Sleep -Seconds 1
		}
	}
	Switch ($xMenu1){    #… User has selected a valid entry.. load next menu
		1 {
			while ( $xMenu2 -lt 1 -or $xMenu2 -gt 7 ){
				#CLS
				# Present the Menu Options
				Write-Host "`n`tLabor verwalten`n" 
				Write-Host "`t`tTreffen Sie eine Auswahl`n" 
				Write-Host "`t`t`t1. Labor aufsetzen" 
				Write-Host "`t`t`t2. Labor zurücksetzen" 
				Write-Host "`t`t`t3. Labor löschen"
                Write-Host "`t`t`t4. Labor starten" 
				Write-Host "`t`t`t5. Labor herunterfahren" 
                Write-Host "`t`t`t6. Labor neustarten" 
                Write-Host "`t`t`t7. Hauptmenü`n" 
				[int]$xMenu2 = Read-Host "`t`tOption: "
				if( $xMenu2 -lt 1 -or $xMenu2 -gt 7 ){
					Write-Host "`tSie können nur eine der aufgeführten Optionen auswählen.`n" -Fore Red;start-Sleep -Seconds 1
				}
			}
			Switch ($xMenu2){
				1{ . $script_path\Manage-Lab\Create-Lab.ps1 }
				2{ . $script_path\Manage-Lab\Reset-Lab.ps1 }
				3{ . $script_path\Manage-Lab\Delete-Lab.ps1 }
                4{ . $script_path\Manage-Lab\Start-Lab.ps1}
                5{ . $script_path\Manage-Lab\Shutdown-Lab.ps1 }
                6{ . $script_path\Manage-Lab\Restart-Lab.ps1 }

				default { Write-Host "`n`tHauptmenü`n" ; break}
			}
		}
		2 {
			while ( $xMenu2 -lt 1 -or $xMenu2 -gt 7 ){
				#CLS
				# Present the Menu Options
				Write-Host "`n`tUmgebung für einen Teilnehmer steuern`n" 
				Write-Host "`t`tTreffen Sie eine Auswahl`n" 
				Write-Host "`t`t`t1. Umgebung für einen Teilnehmer aufsetzen" 
				Write-Host "`t`t`t2. Umgebung für einen Teilnehmer zurücksetzen" 
				Write-Host "`t`t`t3. Umgebung für einen Teilnehmer löschen"
                Write-Host "`t`t`t4. Umgebung für einen Teilnehmer starten"
                Write-Host "`t`t`t5. Umgebung für einen Teilnehmer herunterfahren"   
                Write-Host "`t`t`t6. Umgebung für einen Teilnehmer neustarten" 
				Write-Host "`t`t`t7. Hauptmenü`n" 
				[int]$xMenu2 = Read-Host "`t`tOption:"
			}
			if( $xMenu2 -lt 1 -or $xMenu2 -gt 7 ){
				Write-Host "`tSie können nur eine der aufgeführten Möglichkeiten auswählen`n" -Fore Red;start-Sleep -Seconds 1
			}
			Switch ($xMenu2){
				1{ . $script_path\Manage-Environment\Create-Environment.ps1 }
				2{ . $script_path\Manage-Environment\Reset-Environment.ps1 }
				3{ . $script_path\Manage-Environment\Delete-Environment.ps1 }
                4{ . $script_path\Manage-Environment\Start-Environment.ps1 }
                5{ . $script_path\Manage-Environment\Shutdown-Environment.ps1 }
                6{ . $script_path\Manage-Environment\Restart-Environment.ps1 }
				default { Write-Host "`n`tHauptmenü`n" ; break}
			}
		}
        3 {
			while ( $xMenu2 -lt 1 -or $xMenu2 -gt 16 ){
				#CLS
				# Present the Menu Options
				Write-Host "`n`tVM Typen verwalten`n" 
				Write-Host "`t`tTreffen Sie eine Auswahl`n" 
				Write-Host "`t`t`t1. Kali VMs starten" 
                Write-Host "`t`t`t2. Kali VMs herunterfahren" 
                Write-Host "`t`t`t3. Kali VMs neustarten"
                Write-Host "`t`t`t4. Kali VMs erstellen"
				Write-Host "`t`t`t5. Metasploitable VMs starten" 
                Write-Host "`t`t`t6. Metasploitable VMs herunterfahren" 
                Write-Host "`t`t`t7. Metasploitable VMs neustarten"
                Write-Host "`t`t`t8. Metasploitable VMs erstellen" 
				Write-Host "`t`t`t9. Windows VMs starten" 
				Write-Host "`t`t`t10. Windows VMs herunterfahren" 
				Write-Host "`t`t`t11. Windows VMs neutstarten"
                Write-Host "`t`t`t12. Windows VMs erstellen"
				Write-Host "`t`t`t13. Windows Server VMs starten" 
				Write-Host "`t`t`t14. Windows Server VMs herunterfahren" 
				Write-Host "`t`t`t15. Windows Server VMs neustarten"
				Write-Host "`t`t`t16. Hauptmenü`n" 
				[int]$xMenu2 = Read-Host "`t`tOption:"
				if( $xMenu2 -lt 1 -or $xMenu2 -gt 16 ){
					Write-Host "`tSie können nur eine der aufgeführten Möglichkeiten auswählen`n" -Fore Red;start-Sleep -Seconds 1
				}
			}
			Switch ($xMenu2){
				1{ . $script_path\Manage-VMTypes\Start-KaliVMs.ps1 }
				2{ . $script_path\Manage-VMTypes\Shutdown-KaliVMs.ps1 }
				3{ . $script_path\Manage-VMTypes\Restart-KaliVMs.ps1 }
                4{ . $script_path\Manage-VMTypes\Create-VMTypes.ps1 -VM_Type Kali}
                5{ . $script_path\Manage-VMTypes\Start-MetasploitableVMs.ps1 }
                6{ . $script_path\Manage-VMTypes\Shutdown-MetasploitableVMs.ps1 }
                7{ . $script_path\Manage-VMTypes\Restart-MetasploitableVMs.ps1 }
                8{ . $script_path\Manage-VMTypes\Create-VMTypes.ps1 -VM_Type Metasploitable}
                9{ . $script_path\Manage-VMTypes\Start-WindowsVMs.ps1 }
                10{ . $script_path\Manage-VMTypes\Shutdown-WindowsVMs.ps1 }
                11{ . $script_path\Manage-VMTypes\Restart-WindowsVMs.ps1 }
                12{ . $script_path\Manage-VMTypes\Create-VMTypes.ps1 -VM_Type Windows}
                13{ . $script_path\Manage-VMTypes\Start-WindowsServerVMs.ps1 }
                14{ . $script_path\Manage-VMTypes\Shutdown-WindowsServerVMs.ps1 }
                15{ . $script_path\Manage-VMTypes\Restart-WindowsServerVMs.ps1 }
				default { Write-Host "`n`tHauptmenü`n" ; break}
			}
		}
		4 {
			while ( $xMenu2 -lt 1 -or $xMenu2 -gt 15 ){
				#CLS
				# Present the Menu Options
				Write-Host "`n`tEinzelne VMs steuern`n" 
				Write-Host "`t`tTreffen Sie eine Auswahl`n" 
				Write-Host "`t`t`t1. Kali-VM für Teilnehmer X aufsetzen" 
                Write-Host "`t`t`t2. Kali-VM von Teilnehmer X zurücksetzen" 
                Write-Host "`t`t`t3. Kali-VM von Teilnehmer X neustarten" 
				Write-Host "`t`t`t4. Metasploitable VM für Teilnehmer X aufsetzen" 
                Write-Host "`t`t`t5. Metasploitable VM von Teilnehmer X zurücksetzen" 
                Write-Host "`t`t`t6. Metasploitable VM von Teilnehmer X neustarten" 
				Write-Host "`t`t`t7. Windows-VM für Teilnehmer X aufsetzen" 
				Write-Host "`t`t`t8. Windows-VM von Teilnehmer X zurücksetzen" 
				Write-Host "`t`t`t9. Windows-VM von Teilnehmer X neustarten"
				Write-Host "`t`t`t10. Windows Server VM aufsetzen" 
				Write-Host "`t`t`t11. Windows Server zurücksetzen" 
				Write-Host "`t`t`t12. Windows Server VM neustarten"
                Write-Host "`t`t`t13. Template Schreibschutz aktivieren"
                Write-Host "`t`t`t14. Template Schreibschutz deaktivieren"                
				Write-Host "`t`t`t15. Hauptmenü`n" 
				[int]$xMenu2 = Read-Host "`t`tOption:"
				if( $xMenu2 -lt 1 -or $xMenu2 -gt 15 ){
					Write-Host "`tSie können nur eine der aufgeführten Möglichkeiten auswählen`n" -Fore Red;start-Sleep -Seconds 1
				}
			}
			Switch ($xMenu2){
				1{ . $script_path\Manage-VM\Create-KaliVM.ps1 }
				2{ . $script_path\Manage-VM\Reset-KaliVM.ps1 }
				3{ . $script_path\Manage-VM\Restart-KaliVM.ps1 }
                4{ . $script_path\Manage-VM\Create-MetasploitableVM.ps1 }
                5{ . $script_path\Manage-VM\Reset-MetasploitableVM.ps1 }
                6{ . $script_path\Manage-VM\Restart-MetasploitableVM.ps1 }
                7{ . $script_path\Manage-VM\Create-WindowsVM.ps1 }
                8{ . $script_path\Manage-VM\Reset-WindowsVM.ps1 }
                9{ . $script_path\Manage-VM\Restart-WindowsVM.ps1 }
                10{ . $script_path\Manage-VM\Create-WindowsServerVM.ps1 }
                11{ . $script_path\Manage-VM\Reset-WindowsServerVM.ps1 }
                12{ . $script_path\Manage-VM\Restart-WindowsServerVM.ps1 }
                13{. $script_path\Manage-VM\Enable-ReadMode.ps1}
                14{. $script_path\Manage-VM\Disable-ReadMode.ps1}
				default { Write-Host "`n`tHauptmenü`n" ; break}
			}
		}
		default { $global:xExitSession=$true;break }
        
        5 { . $script_path\Manage-Lab\Show-LabOverview.ps1}
		6 { 
                while ( $xMenu2 -lt 1 -or $xMenu2 -gt 4 ){
				#CLS
				# Present the Menu Options
				Write-Host "`n`tAuslastung HyperV Core anzeigen`n" 
				Write-Host "`t`tTreffen Sie eine Auswahl`n" 
				Write-Host "`t`t`t1. CPU Load" 
                Write-Host "`t`t`t2. RAM Auslastung" 
                Write-Host "`t`t`t3. Auslagerungsdatei" 
				Write-Host "`t`t`t4. Hauptmenü`n" 
				[int]$xMenu2 = Read-Host "`t`tOption:"
				if( $xMenu2 -lt 1 -or $xMenu2 -gt 4 ){
					Write-Host "`tSie können nur eine der aufgeführten Möglichkeiten auswählen`n" -Fore Red;start-Sleep -Seconds 1
				}
			}
			Switch ($xMenu2){
				1{ . $script_path\Manage-Core\Get-CPULoad.ps1 }
				2{ . $script_path\Manage-Core\Get-HostMemoryUsage.ps1 }
				3{ . $script_path\Manage-Core\Get-PageFileInfo.ps1 } 
				default { Write-Host "`n`tHauptmenü`n" ; break}
			}}
        7 { git pull}	
	}
}
LoadMenuSystem
If ($xExitSession){
	exit    #… User quit & Exit
}else{
	. $script_path\Start.ps1    #… Loop the function
}
