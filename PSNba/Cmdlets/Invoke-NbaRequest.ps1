function Invoke-NbaRequest {
    [CmdletBinding()]
    param (
        # Endpoint
        [Parameter(Mandatory = $true)]
        [string]
        $Uri,

        # Method
        [Parameter(Mandatory = $true)]
        [ValidateSet("Get", "Post")]
        [string]
        $Method
    )
    
    begin {
        
    }
    
    process {
        if (![uri]::TryCreate($Uri, [System.UriKind]::Absolute, [ref] $Uri)) {
            Write-Error -Message "Invalid URI: [$($Uri)]" -ErrorAction:Stop
        }

        try {
            Invoke-RestMethod -Uri $Uri -Method:$($Method) 
        }
        catch {
            Write-Error $_ -ErrorAction:Continue
        }
    }
    
    end {
        
    }
}