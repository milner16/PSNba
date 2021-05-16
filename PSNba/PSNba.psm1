$cmdletFiles = Get-ChildItem -Path "$($PSScriptRoot)\*.ps1" -Recurse
foreach ($file in $cmdletFiles) {
    . $file.FullName
}

New-Variable -Name "Config" -Value @{} -Scope:Script 

$ConfigurationFiles = Get-ChildItem -Path "$($PSScriptRoot)\Configuration\*.psd1" -Recurse
foreach ($File in $ConfigurationFiles) {
    $Data = Import-PowerShellDataFile -Path $($File.FullName)
    $Script:Config.Add($File.BaseName, $Data)
}