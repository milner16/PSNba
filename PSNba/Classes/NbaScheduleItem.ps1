class NbaScheduleItem {
    [int] $SeasonStageId
    [int] $SeasonId 
    [string] $GameUrlCode
    [int] $StatusNumber
    [int] $ExtendedStatusNumber
    [string] $GameId
    [datetime] $DateTime
    [string] $StartTimeEastern
    [string] $StartTimeUTC
    [string] $StartDateEastern
    [string] $HomeStartDate
    [int] $HomeStartTime
    [string] $VisitorStartDate
    [int] $VisitorStartTime
    [bool] $IsHomeTeam
    [bool] $IsStartTimeTBD
    $Watch 
    $Nugget
    $HomeTeam 
    $VisitingTeam

    NbaScheduleItem($JsonResponse) {
        $this.SeasonStageId = $JsonResponse.seasonStageId
        $this.SeasonId = $JsonResponse.seasonId
        $this.GameUrlCode = $JsonResponse.gameUrlCode 
        $this.GameId = $JsonResponse.gameId 
        $this.StatusNumber = $JsonResponse.statusNum 
        $this.ExtendedStatusNumber = $JsonResponse.extendedStatusNumber 
        $this.DateTime = [datetime]::Parse($JsonResponse.startTimeUTC)
        $this.StartTimeEastern = $JsonResponse.startTimeEastern 
        $this.StartDateEastern = $JsonResponse.startDateEastern 
        $this.HomeStartDate = $JsonResponse.homeStartDate 
        $this.HomeStartTime = $JsonResponse.homeStartTime 
        $this.VisitorStartDate = $JsonResponse.visitorStartDate 
        $this.VisitorStartTime = $JsonResponse.visitorStartTime 
        $this.IsHomeTeam = $JsonResponse.isHomeTeam 
        $this.IsStartTimeTBD = $JsonResponse.isStartTimeTBD 
        $this.Watch = $JsonResponse.watch 
        $this.Nugget = $JsonResponse.nuggett
        $this.VisitingTeam = $JsonResponse.vTeam 
        $this.HomeTeam = $JsonResponse.hTeam 
    }
}