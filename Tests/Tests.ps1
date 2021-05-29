Import-Module -Name "$($PSScriptRoot)\..\PSNba" -Force
Describe "Get-NbaTeam"{
    It "outputs 'Utah Jazz'"{
        (Get-NbaTeam -TeamId "1610612762" -Year 2019).fullName | Should -Be 'Utah Jazz'
    }
}