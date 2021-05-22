function Get-NbaTeamSchedule {
    [CmdletBinding()]
    param (
        # Team ID
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias("Id")]
        [string]
        $TeamId,

        # Season
        [Parameter(
            Mandatory = $false, 
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(0, 9999)]
        [int]
        $Season,

        # Return Raw JSON 
        [Parameter(Mandatory = $false)]
        [switch]
        $Raw
    )
    
    begin {
    }
    
    process {
        if (-Not($Season)) {
            $Season = $Script:Config.Season.Year
        }
        [string] $Endpoint = $Script:Config.Endpoints.TeamSchedule.Replace("{season}", $Season.ToString("0000"))
        $Endpoint = $Endpoint.Replace("{teamId}", $TeamId) 
        $Response = Invoke-NbaRequest -Uri $Endpoint -Method:Get
        if ($Raw) {
            return $Response
        }
        else {
            foreach ($Item in $Response.league.standard) {
                [NbaScheduleItem]::new($Item)
            }
        }
    }
    
    end {
        
    }
}