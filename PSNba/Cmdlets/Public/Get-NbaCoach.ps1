function Get-NbaCoach {
    [CmdletBinding(DefaultParameterSetName = 'Class')]
    param (
        # Team Name
        [Parameter(
            Mandatory = $false, 
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Class'
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
        $Season,

        # Return the raw JSON response
        [Parameter(
            Mandatory = $false,
            ParameterSetName = 'Raw'
        )]
        [switch]
        $Raw
    )
    
    begin {
        
    }
    
    process {
        if (-Not($Season)) {
            $Season = $Script:Defaults.Season
        }

        [string] $Endpoint = $Script:Config.Endpoints.Coaches.Replace("{season}", $Season.ToString("0000"))
        $Response = Invoke-NbaRequest -Uri $Endpoint -Method:Get

        if ($Raw) {
            return $Response
        }

        $Coaches = $Response.league.standard

        if ($TeamId) {
            $Coaches = $Coaches.Where( { $_.TeamId -eq $TeamId })
        }

        foreach ($Coach in $Coaches) {
            [NbaCoach]::new($Coach)
        }
    }
    
    end {
        
    }
}