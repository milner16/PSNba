$PublicFiles = Get-ChildItem -Path "$($PSScriptRoot)\Cmdlets\Public\*.ps1" -Recurse
$PrivateFiles = Get-ChildItem -Path "$($PSScriptRoot)\Cmdlets\Private\*.ps1" -Recurse 
$ClassFiles = Get-ChildItem -Path "$($PSScriptRoot)\Classes\*.ps1" -Recurse 
foreach ($File in $PublicFiles + $PrivateFiles + $ClassFiles) {
    . $File.FullName
}

Export-ModuleMember -Function $($PublicFiles.BaseName)

New-Variable -Name "Config" -Value @{} -Scope:Script 

$ConfigurationFiles = Get-ChildItem -Path "$($PSScriptRoot)\Configuration\*.psd1" -Recurse
foreach ($File in $ConfigurationFiles) {
    $Data = Import-PowerShellDataFile -Path $($File.FullName)
    $Script:Config.Add($File.BaseName, $Data)
}

New-Variable -Name 'Defaults' -Value @{} -Scope:Script

$Today = (Get-Date)
$CurrentSeason = $Today.Year
if ($Today.Month -lt 9) {
    $CurrentSeason -= 1
}

$Script:Defaults.Add('Season', $CurrentSeason)
