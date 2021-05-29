function Get-NbaStandings {
    [CmdletBinding()]
    param (
        # Standings Type
        [Parameter(Mandatory = $false)]
        [ValidateSet("All", "Conference", "Division")]
        [string]
        $Type = "All",

        # Date
        [Parameter(Mandatory = $false)]
        [Obsolete('-Date is not currently supported. Current Standings will be returned instead.')]
        [datetime]
        $Date,

        # Returns the raw JSON response
        [Parameter(Mandatory = $false)]
        [switch]
        $Raw
    )
    
    begin {
        
    }
    
    process {
        [string] $Endpoint = $Script:Config.Endpoints.Standings.Replace("{type}", $Type.ToLower())
        $Response = Invoke-NbaRequest -Uri $Endpoint -Method:Get

        if ($PSBoundParameters['Raw']) {
            $Response
        }
        else {
            switch ($Type) {
                "All" {  
                    foreach ($TeamEntry in $Response.league.standard.Teams) {
                        [NbaStandingEntry]::new($TeamEntry, $Type)
                    }
                    break
                }
                "Conference" {
                    $ConferenceObjects = $Response.league.standard.conference
                    $ConferenceNames = $ConferenceObjects.PSObject.Properties.Where( { $_.MemberType -eq "NoteProperty" }).Name
                    foreach ($Conference in $ConferenceNames) {
                        foreach ($TeamEntry in $ConferenceObjects.$($Conference)) {
                            [NbaStandingEntry]::new($TeamEntry, $Type)
                        }
                    }
                    break
                }
                "Division" {
                    $ConferenceObjects = $Response.league.standard.conference
                    $ConferenceNames = $ConferenceObjects.PSObject.Properties.Where( { $_.MemberType -eq "NoteProperty" }).Name
                    foreach ($Conference in $ConferenceNames) {
                        $DivisionObjects = $ConferenceObjects.$($Conference)
                        $DivisionNames = $DivisionObjects.PSObject.Properties.Where( { $_.MemberType -eq "NoteProperty" }).Name
                        foreach ($Division in $DivisionNames) {
                            foreach ($TeamEntry in $DivisionObjects.$($Division)) {
                                [NbaStandingEntry]::new($TeamEntry, $Type)
                            }
                        }
                    }
                    break
                }
                Default {
                    $Response
                    break
                }
            }
        }
    }
    
    end {
        
    }
}