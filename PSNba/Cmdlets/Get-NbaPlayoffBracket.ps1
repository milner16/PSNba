function Get-NbaPlayoffBracket {
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
        [string] $endpoint = $Script:Endpoints.PlayoffBracket.Replace("{season}", $Season.ToString("0000"))
        $response = Invoke-NbaRequest -Uri $endpoint -Method:Get
        return $response.series
    }
    
    end {
        
    }
}