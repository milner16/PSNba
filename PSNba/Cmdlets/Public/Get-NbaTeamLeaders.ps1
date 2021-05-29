function Get-NbaTeamLeaders {
    [CmdletBinding()]
    param (
        # Team ID
        [Parameter(
            Mandatory = $true, 
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('Id')]
        [string]
        $TeamId,
        
        # Season
        [Parameter(
            Mandatory = $false, 
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
        if (-Not($Season)) {
            $Season = $Script:Defaults.Season
        }
        [string] $Endpoint = $Script:Config.Endpoints.TeamLeaders.Replace("{season}", $Season.ToString("0000"))
        $Endpoint = $Endpoint.Replace("{teamId}", $TeamId) 
        $Response = Invoke-NbaRequest -Uri $Endpoint -Method:Get
        return $Response.league.standard
    }
    
    end {
        
    }
}