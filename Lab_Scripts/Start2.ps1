# HEMS Startmenü


$xAppName    = "MenuDemo"
[BOOLEAN]$global:xExitSession=$false
function LoadMenuSystem(){
	[INT]$xMenu1=0
	[INT]$xMenu2=0
	[BOOLEAN]$xValidSelection=$false
	while ( $xMenu1 -lt 1 -or $xMenu1 -gt 19 ){
		CLS
		#Hauptmenü
		Write-Host "`n`t Hacking Environment Startmenü`n" -ForegroundColor Magenta
		Write-Host "`t`tPlease select the admin area you require`n" -Fore Cyan
		Write-Host "`t`t`t1. Lab für X Teilnehmer aufsetzen" -Fore Cyan
		Write-Host "`t`t`t2. Lab zurücksetzen" -Fore Cyan
		Write-Host "`t`t`t3. Lab löschen" -Fore Cyan
		Write-Host "`t`t`t4. Lab neustarten" -Fore Cyan
        Write-Host "`t`t`t5. Lab herunterfahren" -Fore Cyan
        Write-Host "`t`t`t6. Umgebung (Kali, Metasploitable & Windows) für einen Teilnehmer aufsetzen" -Fore Cyan
        Write-Host "`t`t`t7. Umgebung (Kali, Metasploitable & Windows) für einen Teilnehmer zurücksetzen" -Fore Cyan
        Write-Host "`t`t`t8. Umgebung (Kali, Metasploitable & Windows) für einen Teilnehmer löschen" -Fore Cyan
        Write-Host "`t`t`t9. Umgebung (Kali, Metasploitable & Windows) für einen Teilnehmer neustarten" -Fore Cyan
        Write-Host "`t`t`t10. Kali-VM von Teilnehmer X aufsetzen" -Fore Cyan
        Write-Host "`t`t`t11. Linux (Metasploitable)-VM von Teilnehmer X aufsetzen" -Fore Cyan
        Write-Host "`t`t`t12. Windows-VM von Teilnehmer X aufsetzen" -Fore Cyan
        Write-Host "`t`t`t13. Kali-VM von Teilnehmer X zurücksetzen" -Fore Cyan
        Write-Host "`t`t`t14. Linux (Metasploitable)-VM von Teilnehmer X zurücksetzen" -Fore Cyan
        Write-Host "`t`t`t15. Windows-VM von Teilnehmer X zurücksetzen" -Fore Cyan
        Write-Host "`t`t`t16. Kali-VM von Teilnehmer X neustarten" -Fore Cyan
        Write-Host "`t`t`t17. Linux (Metasploitable)-VM von Teilnehmer X zurücksetzen" -Fore Cyan
        Write-Host "`t`t`t18. Windows-VM von Teilnehmer X zurücksetzen" -Fore Cyan
        Write-Host "`t`t`t19. Menü verlassen und zurück zur Powershell" -Fore Cyan
		#… Retrieve the response from the user
		[int]$xMenu1 = Read-Host "`t`tEnter Menu Option Number"
		if( $xMenu1 -lt 1 -or $xMenu1 -gt 19 ){
			Write-Host "`tPlease select one of the options available.`n" -Fore Red;start-Sleep -Seconds 1
		}
	}
	Switch ($xMenu1){    #… User has selected a valid entry.. load Scripts
		1 {
			
		}
		2 {
			
		}
		3 {
			
		}
        4 {

        }
        5 {

        }
        6{

        }
        7{

        }
        8 {

        }
        9 {

        }
        10 {

        }
        11 {

        }
        12 {

        }
        13 {

        }
        14 {

        }
        15 {

        }
        16 {

        }
        17 {

        }
        18 {

        }
        
		default { $global:xExitSession=$true }
	}
}
LoadMenuSystem
If ($xExitSession){
	exit    #… User quit & Exit
}else{
	C:\Users\Christian\OneDrive\Studium\Masterarbeit\mITSM\Skripte\Lab_Scripts\Start.ps1    #… Loop the function
}