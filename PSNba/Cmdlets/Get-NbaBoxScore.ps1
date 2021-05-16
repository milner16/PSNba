function Get-NbaBoxScore {
    [CmdletBinding()]
    param (
        # Game ID
        [Parameter(
            Mandatory = $true, 
            ValueFromPipelineByPropertyName = $true
        )]
        [string]
        $GameId,
        
        # Date
        [Parameter(
            Mandatory = $true, 
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias("homeStartDate")]
        [string]
        $Date
    )
    
    begin {
        
    }
    
    process {
        [string] $endpoint = $Script:Config.Endpoints.BoxScore.Replace("{gameId}", $GameId)
        $endpoint = $endpoint.Replace("{date}", $Date) 
        $response = Invoke-NbaRequest -Uri $endpoint -Method:Get
        return $response.sports_content
    }
    
    end {
        
    }
}