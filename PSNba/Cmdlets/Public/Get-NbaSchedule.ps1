function Get-NbaSchedule {
    [CmdletBinding()]
    param (
        # Season
        [Parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(0, 9999)]
        [int]
        $Season,

        # Date
        [Parameter(Mandatory = $false)]
        [DateTime]
        $Date,

        # Return raw json output
        [Parameter(Mandatory = $false)]
        [switch]
        $Raw
    )
    
    begin {
        
    }
    
    process {
        if (-Not($Season)) {
            $Season = $Script:Defaults.Season
        }
        [string] $Endpoint = $Script:Config.Endpoints.Schedule.Replace("{season}", $Season.ToString("0000"))
        $Response = Invoke-NbaRequest -Uri $Endpoint -Method:Get

        if ($Raw) {
            return $Response
        }

        $Items = @()
        foreach ($Item in $Response.league.standard) {
            $Items += [NbaScheduleItem]::new($Item)
        }

        if ($Date) {
            $BeginningOfDay = Get-Date -Date $Date -Hour 0 -Minute 0 -Second 0 -Millisecond 0
            $EndOfDay = Get-Date -Date $Date -Hour 23 -Minute 59
            $Items = $Items.Where( { $_.DateTime -gt $BeginningOfDay -and $_.DateTime -lt $EndOfDay })
        }
        
        return $Items
    }
    
    end {
        
    }
}