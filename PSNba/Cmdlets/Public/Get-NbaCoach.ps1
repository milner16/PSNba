function Get-NbaCoach {
    [CmdletBinding()]
    param (
        # Team Name
        [Parameter(
            Mandatory = $false, 
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

        [string] $Endpoint = $Script:Config.Endpoints.Coaches.Replace("{season}", $Season.ToString("0000"))
        $Response = Invoke-NbaRequest -Uri $Endpoint -Method:Get
        $Response = $Response.league.standard
        
        if ($TeamId) {
            return $Response.Where( { $_.TeamId -eq $TeamId })
        }
        else {
            return $Response
        }
    }
    
    end {
        
    }
}