function Get-NbaPlayer {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        # Year
        [Parameter(
            Mandatory = $false, 
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('Season')]
        [ValidateRange(0, 9999)]
        [int]
        $Year,

        # Player ID
        [Parameter(
            ParameterSetName = 'Default',
            Mandatory = $false, 
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias("personId")]
        [string]
        $PlayerId,

        # Pulls down player list instead of using cached version
        [Parameter(
            Mandatory = $false
        )]
        [switch]
        $Force
    )
    
    begin {
        if (-Not($Year)) {
            $Year = $Script:Defaults.Season
        }
        if ($Force) {
            [string] $Endpoint = $Script:Config.Endpoints.Players.Replace("{year}", $Year.ToString("0000"))
            $Response = Invoke-NbaRequest -Uri $Endpoint -Method:Get
            $Script:Players = @()
            foreach ($Player in $Response.league.standard) {
                $Script:Players += [NbaPlayer]::new($Player)
            }
        }
    }
    
    process {
        if ($PlayerId) {
            return $Script:Players.Where( { $_.personId -eq $PlayerId })
        }
        else {
            return $Script:Players
        }
    }
    
    end {
        
    }
}