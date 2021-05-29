function Get-NbaBoxScore {
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
        [DateTime]
        $Date,

        # Type
        [Parameter(Mandatory = $false)]
        [ValidateSet('Team', 'Player')]
        [string]
        $Type = 'Team',

        # Returns the raw json
        [Parameter(Mandatory = $false)]
        [switch]
        $Raw
    )
    
    begin {
        
    }
    
    process {
        Write-Verbose -Message "Type = $($Type)"
        [string] $Endpoint = $Script:Config.Endpoints.BoxScore.Replace("{gameId}", $GameId)
        $DateString = ConvertTo-DateString -Date $Date
        $Endpoint = $Endpoint.Replace("{date}", $DateString) 
        $Response = Invoke-NbaRequest -Uri $Endpoint -Method:Get

        if ($Raw) {
            return $Response
        }

        [string[]] $TeamTypes = @("visitor", "home")
        
        if ($Type -eq 'Team') {
            foreach ($TeamType in $TeamTypes) {
                $Team = $Response.sports_content.game.$($TeamType) 
                $DateTime = ConvertFrom-DateTimeString -DateString $Response.sports_content.game.date -TimeString $Response.sports_content.game.time
                $BoxScore = [NbaBoxScorePeriod]::new()
                $BoxScore.GameId = $GameId
                $BoxScore.Date = $DateTime
                $BoxScore.TeamName = $Team.abbreviation
                foreach ($LineScore in $Team.linescores.period) {
                    $BoxScore.Periods.Add($LineScore.period_name, $LineScore.score)
                    $BoxScore.TotalScore += $LineScore.score
                }
                $BoxScore
            }
        }

        if ($Type -eq 'Player') {
            foreach ($TeamType in $TeamTypes) {
                $Team = $Response.sports_content.game.$($TeamType) 
                $Players = $Response.sports_content.game.$($TeamType).players.player
                foreach ($Player in $Players) {
                    [NbaBoxScorePlayer]::new($Player, $Team.abbreviation)
                }
            }
        }
    }
    
    end {
        
    }
}