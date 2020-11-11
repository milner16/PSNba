function Get-NbaTeamRoster {
    [CmdletBinding()]
    param (
        # Year
        [Parameter(
            Mandatory = $true, 
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias("Season")]
        [ValidateRange(0, 9999)]
        [int]
        $Year,

        # Team ID
        [Parameter(
            Mandatory = $true, 
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias("urlName")]
        [string]
        $TeamName
    )
    
    begin {
        
    }
    
    process {
        [string] $endpoint = $Script:Endpoints.TeamRoster.Replace("{year}", $Year.ToString("0000"))
        $endpoint = $endpoint.Replace("{teamName}", $TeamName)
        $response = Invoke-NbaRequest -Uri $endpoint -Method:Get
        $team = $response.league.standard
        $team | Add-Member -MemberType NoteProperty -Name "Season" -Value $Year
        return $response.league.standard
    }
    
    end {
        
    }
}