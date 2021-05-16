class NbaStandingEntry {
    [string] $Group
    [string] $Conference
    [long] $TeamId
    [string] $TeamCity
    [string] $TeamNickname
    [string] $TeamLongName
    [string] $TeamShortName
    [string] $TeamAbbreviation
    [int] $Wins
    [int] $Losses
    [double] $WinPercentage
    [double] $LossPercentage
    [double] $GamesBehind
    [double] $DivisionGamesBehind
    [string] $PlayoffStatus
    [int] $ConferenceRank
    [int] $ConferenceWins
    [int] $ConferenceLosses
    [int] $DivisionWins
    [int] $DivisionLosses
    [int] $HomeWins
    [int] $HomeLosses
    [int] $AwayWins
    [int] $AwayLosses
    [int] $LastTenWins
    [int] $LastTenLosses
    [int] $Streak 
    [int] $DivisionRank
    [bool] $IsWinStreak
    [string] $Division

    NbaStandingEntry($JsonObject, $Group) {
        $this.Group = $Group
        $this.TeamId = $JsonObject.teamId
        $TeamInformation = Get-NbaTeam -TeamId $this.TeamId -Year $Script:Config.Season.Year
        $this.TeamCity = $TeamInformation.city
        $this.TeamNickname = $TeamInformation.nickname 
        $this.TeamLongName = $TeamInformation.fullName
        $this.TeamShortName = $TeamInformation.teamShortName 
        $this.Conference = $TeamInformation.confName
        $this.Division = $TeamInformation.divName
        $this.TeamAbbreviation = $TeamInformation.tricode
        $this.Wins = $JsonObject.win
        $this.Losses = $JsonObject.loss
        $this.WinPercentage = $JsonObject.winPct 
        $this.LossPercentage = $JsonObject.lossPct 
        $this.GamesBehind = $JsonObject.gamesBehind 
        $this.DivisionGamesBehind = $JsonObject.divGamesBehind 
        $this.PlayoffStatus = $JsonObject.clinchedPlayoffsCode
        $this.ConferenceRank = $JsonObject.confRank 
        $this.ConferenceWins = $JsonObject.confWin 
        $this.ConferenceLosses = $JsonObject.confLoss 
        $this.DivisionWins = $JsonObject.divWin 
        $this.DivisionLosses = $JsonObject.divLoss 
        $this.HomeWins = $JsonObject.homeWin 
        $this.HomeLosses = $JsonObject.homeLoss 
        $this.AwayWins = $JsonObject.awayWin 
        $this.AwayLosses = $JsonObject.awayLoss 
        $this.LastTenWins = $JsonObject.lastTenWin 
        $this.LastTenLosses = $JsonObject.lastTenLoss 
        $this.Streak = $JsonObject.streak 
        $this.DivisionRank = $JsonObject.divRank 
        $this.IsWinStreak = $JsonObject.isWinStreak
    }
}