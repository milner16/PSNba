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
        $Season
    )
    
    begin {
        
    }
    
    process {
        [string] $Endpoint = $Script:Config.Endpoints.Schedule.Replace("{season}", $Season.ToString("0000"))
        $Response = Invoke-NbaRequest -Uri $Endpoint -Method:Get
        foreach ($Item in $Response.league.standard) {
            [NbaScheduleItem]::new($Item)
        }
    }
    
    end {
        
    }
}