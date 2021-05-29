function ConvertFrom-DateTimeString {
    [CmdletBinding()]
    param (
        # Date String
        [Parameter(Mandatory = $true)]
        [string]
        $DateString,
        # Time String
        [Parameter(Mandatory = $false)]
        [string]
        $TimeString
    )
    
    begin {
        
    }
    
    process {
        $Date = [datetime]::ParseExact($DateString, "yyyyMMdd", [cultureinfo]::InvariantCulture)
        if ($TimeString) {
            $TimeString = [int]::Parse($TimeString).ToString("0000")
            $Hour = $TimeString.Substring(0, 2)
            $Minute = $TimeString.Substring(2, 2)
        }
        else {
            $Hour = 0
            $Minute = 0
        }

        $DateTime = Get-Date -Date $Date -Hour $Hour -Minute $Minute
        return $DateTime
    }
    
    end {
        
    }
}