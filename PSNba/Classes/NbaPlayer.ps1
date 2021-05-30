class NbaPlayer {
    [string] $FirstName
    [string] $LastName
    [string] $TemporaryDisplayName
    [string] $PersonId
    [string] $TeamId 
    [int] $JerseyNumber
    [bool] $IsActive
    [string]$Position 
    [int] $HeightFeet
    [int] $HeightInches
    [double] $HeightMeters
    [double] $WeightPounds
    [double] $WeightKilograms
    [datetime] $DateOfBirth
    $Teams = @()
    $Draft = @()
    [int] $NbaDebutYear
    [int] $YearsPro
    [string] $CollegeName
    [string] $LastAffiliation
    [string] $Country

    NbaPlayer($JsonResponse) {
        $this.FirstName = $JsonResponse.firstName 
        $this.LastName = $JsonResponse.lastName 
        $this.TemporaryDisplayName = $JsonResponse.temporaryDisplayName 
        $this.PersonId = $JsonResponse.personId  
        $this.TeamId = $JsonResponse.teamId 
        $this.JerseyNumber = $JsonResponse.jersey 
        $this.IsActive = $JsonResponse.isActive 
        $this.Position = $JsonResponse.pos     
        if ($JsonResponse.heightFeet -eq '-') {
            $this.HeightFeet = 0
        }
        else {
            $this.HeightFeet = $JsonResponse.heightFeet 
        }
        if ($JsonResponse.heightInches -eq '-') {
            $this.HeightInches = 0
        }
        else {
            $this.HeightInches = $JsonResponse.heightInches 
        }
        $this.HeightMeters = $JsonResponse.heightMeters 
        $this.WeightPounds = $JsonResponse.weightPounds 
        $this.WeightKilograms = $JsonResponse.weightKilograms 
        if ($JsonResponse.dateOfBirthUTC) {
            $this.DateOfBirth = $JsonResponse.dateOfBirthUTC 
        }
        $this.Teams = $JsonResponse.teams 
        $this.Draft = $JsonResponse.Draft 
        $this.NbaDebutYear = $JsonResponse.nbaDebutYear 
        $this.YearsPro = $JsonResponse.yearsPro 
        $this.CollegeName = $JsonResponse.collegeName 
        $this.LastAffiliation = $JsonResponse.lastAffiliation 
        $this.Country = $JsonResponse.country
    }

    [string] GetInfo() {
        return "$($this.JerseyNumber) $($this.LastName) ($($this.Position))"
    }
}