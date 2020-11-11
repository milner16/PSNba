function Get-NbaTeamStatRanking {
    [CmdletBinding()]
    param (
        # Season
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(0, 9999)]
        [int]
        $Season
    )
    
    begin {
        
    }
    
    process {
        [string] $endpoint = $Script:Endpoints.TeamStatsRankings.Replace("{season}", $Season.ToString("0000")) 
        $response = Invoke-NbaRequest -Uri $endpoint -Method:Get
        return $response.league.standard
    }
    
    end {
        
    }
}