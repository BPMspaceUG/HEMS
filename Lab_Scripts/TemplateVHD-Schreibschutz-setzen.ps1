Set-ItemProperty -Path "D:\VM-Templates\_Kali_Template\_Kali_Template.vhdx" -Name IsReadOnly -Value $true
Set-ItemProperty -Path "D:\VM-Templates\_Metasploitable_Template\_Metasploitable_Template.vhdx" -Name IsReadOnly -Value $true
Set-ItemProperty -Path "D:\VM-Templates\_Windows_Template\_Windows_Template.vhdx" -Name IsReadOnly -Value $true

Get-item "D:\VM-Templates\_Kali_Template\_Kali_Template.vhdx"
Get-item "D:\VM-Templates\_Metasploitable_Template\_Metasploitable_Template.vhdx" 
Get-item "D:\VM-Templates\_Windows_Template\_Windows_Template.vhdx"
