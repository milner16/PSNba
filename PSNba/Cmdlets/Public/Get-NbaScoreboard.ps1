function Get-NbaScoreboard {
    [CmdletBinding()]
    param (
        # Date
        [Parameter(
            Mandatory = $true, 
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias("homeStartDate")]
        [datetime]
        $Date
    )
    
    begin {
        
    }
    
    process {
        [string] $dateStr = ConvertTo-DateString -Date $Date
        [string] $endpoint = $Script:Config.Endpoints.Scoreboard.Replace("{date}", $dateStr) 
        $response = Invoke-NbaRequest -Uri $endpoint -Method:Get
        return $response.sports_content.sports_meta
    }
    
    end {
        
    }
}