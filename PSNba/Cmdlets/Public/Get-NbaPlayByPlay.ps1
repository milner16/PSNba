function Get-NbaPlayByPlay {
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
        [Alias("DateTime")]
        [datetime]
        $Date,

        # Return raw json
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
        [string] $DateStr = ConvertTo-DateString -Date $Date
        [string] $Endpoint = $Script:Config.Endpoints.PlayByPlay.Replace("{gameId}", $GameId)
        $Endpoint = $endpoint.Replace("{date}", $DateStr) 
        $Response = Invoke-NbaRequest -Uri $Endpoint -Method:Get

        if ($Raw) {
            return $Response
        }

        $Plays = $Response.sports_content.game.play
        foreach ($Play in $Plays) {
            [NbaPlaybyPlayEvent]::new($Play)
        }
    }
    
    end {
        
    }
}