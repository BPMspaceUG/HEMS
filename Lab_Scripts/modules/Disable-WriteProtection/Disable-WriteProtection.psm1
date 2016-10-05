param (
[string]$Path
)

Set-ItemProperty -Path $Path -Name IsReadOnly -Value $false
Set-ItemProperty -Path $Path -Name IsReadOnly -Value $false
Set-ItemProperty -Path $Path -Name IsReadOnly -Value $false

<#
Get-item "D:\VM-Templates\_Kali_Template\_Kali_Template.vhdx"
Get-item "D:\VM-Templates\_Metasploitable_Template\_Metasploitable_Template.vhdx" 
Get-item "D:\VM-Templates\_Windows_Template\_Windows_Template.vhdx"
#>