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
            ParameterSetName = "TeamName"
        )]
        [string]
        $Name,

        # Type
        [Parameter(
            Mandatory = $true,
            ParameterSetName = "Type"
        )]
        [ValidateSet("Nba", "AllStar", "International")]
        [string]
        $Type,

        # Year
        [Parameter(
            Mandatory = $false, 
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(0, 9999)]
        [Alias("Season")]
        [int]
        $Year
    )
    
    begin {
        if (-Not($Year)) {
            $Year = $Script:Config.Season.Year
        }
        [string] $endpoint = $Script:Config.Endpoints.Teams.Replace("{year}", $Year.ToString("0000"))
        $Response = Invoke-NbaRequest -Uri $endpoint -Method:Get
        $TeamList = $response.league.standard
    }
    
    process {
        if ($PSCmdlet.ParameterSetName -eq 'TeamId') {
            $Teams = $TeamList.Where( { $_.teamId -eq $TeamId })
        }
        elseif ($PSCmdlet.ParameterSetName -eq 'TeamName') {
            $Teams = $TeamList.Where( { $_.fullName -like $Name })
        }
        elseif ($PSCmdlet.ParameterSetName -eq 'Type') {
            switch ($Type) {
                "Nba" { $Teams = $TeamList.Where( { $_.isNbaFranchise }); break; }
                "AllStar" { $Teams = $TeamList.Where( { $_.isAllStar }); break; }
                "International" { $Teams = $TeamList.Where( { $_.confName -eq "Intl" }); break; }
                Default { break; }
            }
        }

        foreach ($Team in $Teams) {
            [NbaTeam]::new($Team, $Year)
        }
    }
    
    end {
        
    }
}