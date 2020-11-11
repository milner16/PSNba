$cmdletFiles = Get-ChildItem -Path "$($PSScriptRoot)\*.ps1" -Recurse
foreach($file in $cmdletFiles){
    . $file.FullName
}

New-Variable -Name "Endpoints" -Value (Import-PowerShellDataFile -Path "$($PSScriptRoot)\Configuration\Endpoints.psd1")

# Testing
#testing 
#testing
#testing
