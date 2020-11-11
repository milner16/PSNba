# PSNba
This module uses the data.nba endpoints to return information about players, teams, coaches, standings, etc.

# Installation
The module is deployed to the PowerShell gallery. You can install it on your PC by running:

    Install-Module -Name 'PSNba'

# About
The benefit of a PowerShell module is that you can utilize the 'pipeline' to connect commands together. 

For example, `Get-NbaCoach` requires the `TeamId` while `Get-NbaTeam` does not. So you can use the output from `Get-NbaTeam` to provide the `TeamId` to `Get-NbaCoach` using the pipeline:

    Get-NbaTeam -Name 'Utah Jazz' -Year 2019
    
    isNBAFranchise : True
    isAllStar      : False
    city           : Utah
    altCityName    : Utah
    fullName       : Utah Jazz
    tricode        : UTA
    teamId         : 1610612762
    nickname       : Jazz
    urlName        : jazz
    teamShortName  : Utah
    confName       : West
    divName        : Northwest
    Season         : 2019
    
    Get-NbaTeam -Name 'Utah Jazz' -Year 2019 | Get-NbaCoach
    
    firstName     : Quin
    lastName      : Snyder
    isAssistant   : False
    personId      : 202439
    teamId        : 1610612762
    sortSequence  : 20
    college       : Duke
    teamSitesOnly : @{displayName=Snyder, Quin; coachCode=quin_snyder; coachRole=1; teamCode=jazz; teamTricode=UTA}

    firstName     : Johnnie
    lastName      : Bryant
    isAssistant   : True
    personId      : 204008
    teamId        : 1610612762
    sortSequence  : 231
    college       : Utah
    teamSitesOnly : @{displayName=Bryant, Johnnie; coachCode=johnnie_bryant; coachRole=2; teamCode=jazz; teamTricode=UTA}

Not all of the commands have been setup for this, but that's the eventual goal.

I'm also looking for any additional endpoints that might be out there, since this is an undocumented API, I've relied on other Python/JavaScript libraries to gather them.
