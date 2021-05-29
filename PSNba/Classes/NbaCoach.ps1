class NbaCoach {
    [string] $FirstName
    [string] $LastName 
    [bool] $IsAssistant
    [string] $PersonId
    [string] $TeamId 
    [string] $College

    NbaCoach($JsonResponse) {
        $this.FirstName = $JsonResponse.firstName 
        $this.LastName = $JsonResponse.lastName 
        $this.IsAssistant = $JsonResponse.isAssistant 
        $this.PersonId = $JsonResponse.personId 
        $this.TeamId = $JsonResponse.teamId
        $this.College = $JsonResponse.college
    }
}