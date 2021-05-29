function Get-NbaTeamStatRanking {
    [CmdletBinding()]
    param (
        # Season
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(0, 9999)]
        [Alias('Year')]
        [int]
        $Season
    )
    
    begin {
        
    }
    
    process {
        [string] $Endpoint = $Script:Config.Endpoints.TeamStatsRankings.Replace("{season}", $Season.ToString("0000")) 
        $Response = Invoke-NbaRequest -Uri $Endpoint -Method:Get
        return $Response.league.standard
    }
    
    end {
        
    }
}