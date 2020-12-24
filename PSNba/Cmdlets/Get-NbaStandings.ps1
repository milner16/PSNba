function Get-NbaStandings {
    [CmdletBinding()]
    param (
        # Date
        [Parameter(Mandatory = $false)]
        [datetime]
        $Date,

        # Standings Type
        [Parameter(Mandatory = $false)]
        [ValidateSet("All", "Conference", "Division")]
        [string]
        $Type = "All"
    )
    
    begin {
        
    }
    
    process {
        if ($Date) {
            [string] $dateStr = ConvertTo-DateString -Date $Date
        }
        else {
            $dateStr = "current"
        }
        [string] $endpoint = $Script:Endpoints.Standings.Replace("{date}", $dateStr)
        $endpoint = $endpoint.Replace("{type}", $Type.ToLower())
        $response = Invoke-NbaRequest -Uri $endpoint -Method:Get
        return $response.league.standard
    }
    
    end {
        
    }
}