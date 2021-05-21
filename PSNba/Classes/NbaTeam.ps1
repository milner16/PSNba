class NbaTeam {
    [string] $AlternateCityName
    [string] $City
    [string] $ConferenceName
    [string] $DivisionName
    [string] $FullName
    [bool] $IsAllStar
    [bool] $IsNbaFranchise
    [string] $Nickname
    [int] $Season 
    [string] $Id 
    [string] $ShortName
    [string] $TriCode
    [string] $UrlName

    NbaTeam($JsonResponse, [int] $Season){
        $this.AlternateCityName = $JsonResponse.altCityName 
        $this.City = $JsonResponse.city 
        $this.ConferenceName = $JsonResponse.confName 
        $this.DivisionName = $JsonResponse.divName 
        $this.FullName = $JsonResponse.fullName 
        $this.IsAllStar = $JsonResponse.isAllStar
        $this.IsNbaFranchise = $JsonResponse.isNBAFranchise 
        $this.Nickname = $JsonResponse.nickname 
        $this.Season = $Season
        $this.Id = $JsonResponse.teamId 
        $this.ShortName = $JsonResponse.teamShortName
        $this.TriCode = $JsonResponse.tricode 
        $this.UrlName = $JsonResponse.urlName
    }
}