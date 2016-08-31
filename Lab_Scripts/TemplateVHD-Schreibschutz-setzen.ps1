Set-ItemProperty -Path "D:\VM-Templates\Kali_Training\Kali_Training.vhdx" -Name IsReadOnly -Value $true
Set-ItemProperty -Path "D:\VM-Templates\Metasploitable_Training\Metasploitable_Training.vhdx" -Name IsReadOnly -Value $true
Set-ItemProperty -Path "D:\VM-Templates\Windows_Training\Windows_Training.vhdx" -Name IsReadOnly -Value $true

Get-item "D:\VM-Templates\Kali_Training\Kali_Training.vhdx"
Get-item "D:\VM-Templates\Metasploitable_Training\Metasploitable_Training.vhdx" 
Get-item "D:\VM-Templates\Windows_Training\Windows_Training.vhdx"
