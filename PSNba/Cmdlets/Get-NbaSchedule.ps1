function Get-NbaSchedule {
    [CmdletBinding()]
    param (
        # Season
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(0, 9999)]
        [int]
        $Season,

        # Date
        [Parameter(Mandatory = $false)]
        [DateTime]
        $Date
    )
    
    begin {
        
    }
    
    process {
        [string] $Endpoint = $Script:Config.Endpoints.Schedule.Replace("{season}", $Season.ToString("0000"))
        $Response = Invoke-NbaRequest -Uri $Endpoint -Method:Get
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
    
    end {
        
    }
}