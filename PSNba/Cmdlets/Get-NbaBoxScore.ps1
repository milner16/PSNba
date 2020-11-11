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
        [DateTime]
        $Date
    )
    
    begin {
        
    }
    
    process {
        [string] $dateStr = ConvertTo-DateString -Date $Date
        [string] $endpoint = $Script:Endpoints.BoxScore.Replace("{gameId}", $GameId)
        $endpoint = $endpoint.Replace("{date}", $dateStr) 
        $response = Invoke-NbaRequest -Uri $endpoint -Method:Get
        return $response.sports_content
    }
    
    end {
        
    }
}