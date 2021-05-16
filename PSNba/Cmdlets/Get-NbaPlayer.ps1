function Get-NbaPlayer {
    [CmdletBinding()]
    param (
        # Year
        [Parameter(
            Mandatory = $true, 
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias("Season")]
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
        [string] $endpoint = $Script:Config.Endpoints.Players.Replace("{year}", $Year.ToString("0000"))
        $response = Invoke-NbaRequest -Uri $endpoint -Method:Get
        $players = $response.league.standard
    }
    
    process {
        if ($PlayerId) {
            return $players.Where( { $_.personId -eq $PlayerId })
        }
        return $players
    }
    
    end {
        
    }
}