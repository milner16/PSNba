function Get-NbaTeamSchedule {
    [CmdletBinding()]
    param (
        # Team ID
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [string]
        $TeamId,

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
        [string] $endpoint = $Script:Endpoints.TeamSchedule.Replace("{season}", $Season.ToString("0000"))
        $endpoint = $endpoint.Replace("{teamId}", $TeamId) 
        $response = Invoke-NbaRequest -Uri $endpoint -Method:Get
        return $response.league.standard
    }
    
    end {
        
    }
}