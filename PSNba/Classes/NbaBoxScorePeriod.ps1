class NbaBoxScorePeriod {
    [int] $GameId
    [string] $TeamName
    [hashtable] $Periods = @{}
    [int] $TotalScore
    [DateTime] $Date
    [bool] $Status
}

 