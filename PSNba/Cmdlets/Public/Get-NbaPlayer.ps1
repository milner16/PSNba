function Get-NbaPlayer {
    [CmdletBinding()]
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
            Mandatory = $false, 
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias("personId")]
        [string]
        $PlayerId
    )
    
    begin {
        if(-Not($Year)){
            $Year = $Script:Defaults.Season
        }
        [string] $Endpoint = $Script:Config.Endpoints.Players.Replace("{year}", $Year.ToString("0000"))
        $Response = Invoke-NbaRequest -Uri $Endpoint -Method:Get
        $Players = $Response.league.standard
    }
    
    process {
        if ($PlayerId) {
            return $Players.Where( { $_.personId -eq $PlayerId })
        }
        return $Players
    }
    
    end {
        
    }
}