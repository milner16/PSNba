function Get-NbaCoach {
    [CmdletBinding()]
    param (
        # Team Name
        [Parameter(
            Mandatory = $false, 
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
        [Alias("Year")]
        [int]
        $Season
    )
    
    begin {
        
    }
    
    process {
        [string] $endpoint = $Script:Endpoints.Coaches.Replace("{season}", $Season.ToString("0000"))
        $response = Invoke-NbaRequest -Uri $endpoint -Method:Get
        $response = $response.league.standard
        if ($TeamId) {
            return $response.Where( { $_.TeamId -eq $TeamId })
        }
        else {
            return $response
        }
    }
    
    end {
        
    }
}