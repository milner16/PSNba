function Get-NbaTeamRoster {
    [CmdletBinding()]
    param (
        # Year
        [Parameter(
            Mandatory = $false, 
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('Year')]
        [ValidateRange(0, 9999)]
        [int]
        $Season,

        # Team ID
        [Parameter(
            Mandatory = $true, 
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias("urlName")]
        [string]
        $TeamName
    )
    
    begin {
        
    }
    
    process {
        if (-Not($Season)) {
            $Season = $Script:Defaults.Season
        }
        [string] $Endpoint = $Script:Config.Endpoints.TeamRoster.Replace("{season}", $Season.ToString("0000"))
        $Endpoint = $endpoint.Replace("{teamName}", $TeamName)
        $Response = Invoke-NbaRequest -Uri $endpoint -Method:Get
        $Team = $response.league.standard
        $Team | Add-Member -MemberType NoteProperty -Name "Season" -Value $Season
        return $Team
    }
    
    end {
        
    }
}