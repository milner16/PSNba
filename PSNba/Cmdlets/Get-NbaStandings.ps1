function Get-NbaStandings {
    [CmdletBinding()]
    param (
        # Standings Type
        [Parameter(Mandatory = $false)]
        [ValidateSet("All", "Conference", "Division")]
        [string]
        $Type = "All",

        # Date
        [Parameter(Mandatory = $false)]
        [Obsolete('-Date is not currently supported. Current Standings will be returned instead.')]
        [datetime]
        $Date
    )
    
    begin {
        
    }
    
    process {
        [string] $Endpoint = $Script:Endpoints.Standings.Replace("{type}", $Type.ToLower())
        $response = Invoke-NbaRequest -Uri $endpoint -Method:Get
        return $response.league.standard
    }
    
    end {
        
    }
}