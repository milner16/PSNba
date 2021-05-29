function ConvertTo-DateString {
    [CmdletBinding()]
    param (
        # Date Time
        [Parameter(Mandatory = $true)]
        [datetime]
        $Date
    )
    
    begin {
        return $Date.ToString("yyyyMMdd")
    }
    
    process {
        
    }
    
    end {
        
    }
}