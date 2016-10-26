#Set-ReadMode.ps1

param (
$switch_value
    )

$template_location = "C:\VM-Templates"

Set-ItemProperty -Path "$template_location\_Kali_Template\_Kali_Template.vhdx" -Name IsReadOnly -Value $True
Set-ItemProperty -Path "$template_location\_Metasploitable_Template\_Metasploitable_Template.vhdx" -Name IsReadOnly -Value $True
Set-ItemProperty -Path "$template_location\_Windows_Template\_Windows_Template.vhdx" -Name IsReadOnly -Value $True
Set-ItemProperty -Path "$template_location\_Windows_Server_Template\_Windows_Server_Template.vhdx" -Name IsReadOnly -Value $True