function Get-NbaPlayoffBracket {
    [CmdletBinding()]
    param (
        # Season
        [Parameter(
            Mandatory = $false, 
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange(0, 9999)]
        [int]
        $Season
    )
    
    begin {
        
    }
    
    process {
        if (-Not($Season)) {
            $Season = $Script:Defaults.Season
        }
        [string] $Endpoint = $Script:Config.Endpoints.PlayoffBracket.Replace("{season}", $Season.ToString("0000"))
        $Response = Invoke-NbaRequest -Uri $endpoint -Method:Get
        return $Response.series
    }
    
    end {
        
    }
}