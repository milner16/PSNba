function Get-NbaTeam {
    [CmdletBinding()]
    param (
        # Team ID
        [Parameter(
            Mandatory = $true, 
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = "TeamId"
        )]
        [string]
        $TeamId,

        # Team Name
        [Parameter(
            Mandatory = $true,
            ParameterSetName = "Name"
        )]
        [string]
        $Name,

        # Year
        [Parameter(
            Mandatory = $false, 
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(0, 9999)]
        [Alias("Season")]
        [int]
        $Year,

        # Type
        [Parameter(Mandatory = $false)]
        [ValidateSet("Nba", "AllStar", "International")]
        [string]
        $Type="Nba"
    )
    
    begin {
        if (!$Year) {
            $Year = (Get-Date).Year
        }
        [string] $endpoint = $Script:Config.Endpoints.Teams.Replace("{year}", $Year.ToString("0000"))
        $response = Invoke-NbaRequest -Uri $endpoint -Method:Get
        $teams = $response.league.standard
    }
    
    process {
        if ($Name) {
            $teams = $teams.Where( { $_.FullName -eq $Name })
        }
        elseif ($TeamId) {
            $teams = $teams.Where( { $_.teamId -eq $TeamId })
        }

        switch ($Type) {
            "Nba" { $teams = $teams.Where( { $_.isNbaFranchise }); break; }
            "AllStar" { $teams = $teams.Where( { $_.isAllStar }); break; }
            "International" { $teams = $teams.Where( { $_.confName -eq "Intl" }); break; }
            Default {}
        }

        foreach ($team in $teams) {
            $team | Add-Member -MemberType NoteProperty -Name "Season" -Value $Year
        }
        return $teams
    }
    
    end {
        
    }
}