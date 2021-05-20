class NbaBoxScorePlayer {
    [string] $Team 
    [string] $FirstName
    [string] $LastName
    [int] $JerseyNumber 
    [string] $PositionShort
    [string] $PositionLong
    [int] $Minutes 
    [int] $Seconds
    [int] $Points 
    [int] $FieldGoalsMade
    [int] $FieldGoalsAttempted
    [int] $FreeThrowsMade
    [int] $FreeThrowsAttempted
    [int] $ThreePointersMade
    [int] $ThreePointersAttempted
    [int] $ReboundsOffensive
    [int] $ReboundsDefensive
    [int] $Assists
    [int] $Fouls
    [int] $Steals 
    [int] $Turnovers 
    [int] $Blocks 
    [int] $PlusMinus

    NbaBoxScorePlayer($Player, [string] $TeamName){
        $this.Team = $TeamName
        $this.FirstName = $Player.first_name
        $this.LastName = $Player.last_name
        $this.JerseyNumber = $Player.jersey_number
        $this.PositionShort = $Player.position_short
        $this.PositionLong = $Player.position_full
        $this.Minutes = $Player.minutes
        $this.Seconds = $Player.seconds
        $this.Points = $Player.points
        $this.FieldGoalsMade = $Player.field_goals_made
        $this.FieldGoalsAttempted = $Player.field_goals_attempted
        $this.FreeThrowsMade = $Player.free_throws_made
        $this.FreeThrowsAttempted = $Player.free_throws_attempted
        $this.ThreePointersMade = $Player.three_pointers_made
        $this.ThreePointersAttempted = $Player.three_pointers_attempted
        $this.ReboundsDefensive = $Player.rebounds_defensive
        $this.ReboundsOffensive =$Player.rebounds_offensive
        $this.Assists = $Player.assists
        $this.Fouls = $Player.fouls
        $this.Steals = $Player.steals
        $this.Turnovers = $Player.turnovers
        $this.Blocks = $Player.blocks
        $this.PlusMinus = $Player.plus_minus
    }
}