$ping = Test-Connection 8.8.8.8 -Quiet

$source = "https://raw.githubusercontent.com/BPMspaceUG/HEMS/master/_Windows_Template/VM_Autoconfiguration_Windows.ps1"
$destination = "C:\vm-autoconfiguration.ps1"

foreach($p in $ping)
    {if($p -eq $true)
        {
        Invoke-WebRequest $source -OutFile $destination

        Write-Output "Update von VM-Autoconfiguration.ps1 erfolgreich durchgeführt."
        }

    else
        {Write-Output "Update von VM-Autoconfiguration.ps1 fehlgeschlagen."}

}

. C:\vm-autoconfiguration.ps1