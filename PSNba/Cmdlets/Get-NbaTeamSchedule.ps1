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
        [Alias('Year')]
        [int]
        $Season,

        # Date
        [Parameter(Mandatory = $false)]
        [DateTime]
        $Date,

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
            $Items = @()
            foreach ($Item in $Response.league.standard) {
                $Items += [NbaScheduleItem]::new($Item)
            }
            
            $BeginningOfDay = Get-Date -Date $Date -Hour 0 -Minute 0 -Second 0 -Millisecond 0
            $EndOfDay = Get-Date -Date $Date -Hour 23 -Minute 59
            if ($Date) {
                $Items.Where( { $_.DateTime -gt $BeginningOfDay -and $_.DateTime -lt $EndOfDay })
            }
            else {
                $Items
            }
        }
    }
    
    end {
        
    }
}