class NbaPlaybyPlayEvent {
    [int] $EventId
    [string] $Clock
    [string] $Description
    [string] $PlayerCode
    [string] $PersonId 
    [int] $HomeScore 
    [int] $VisitorScore
    [string] $TeamAbbreviation
    [int] $Period

    NbaPlaybyPlayEvent($JsonResponse) {
        $this.EventId = $JsonResponse.event  
        $this.Clock = $JsonResponse.clock 
        $this.Description = $JsonResponse.description
        $this.PlayerCode = $JsonResponse.player_code 
        $this.PersonId = $JsonResponse.person_id 
        $this.HomeScore = $JsonResponse.home_score 
        $this.VisitorScore = $JsonResponse.visitor_score 
        $this.TeamAbbreviation = $JsonResponse.team_abr 
        $this.Period = $JsonResponse.period 
    }
}