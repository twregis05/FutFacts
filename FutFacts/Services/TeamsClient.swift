//
//  TeamsClient.swift
//  FutFacts
//
//  Created by Trenton Regis on 8/20/25.
//

import Foundation

struct League
{
    let id: Int
    let name: String
    let code: String
    let emblem: String
    let country: String
}

let leagueList: [League] = [
    League(id: 2013, name: "Campeonato Brasileiro Série A", code: "BSA", emblem: "https://crests.football-data.org/bsa.png", country: "Brazil"),
    League(id: 2016, name: "Championship", code: "ELC", emblem: "https://crests.football-data.org/ELC.png", country: "England"),
    League(id: 2021, name: "Premier League", code: "PL", emblem: "https://crests.football-data.org/PL.png", country: "England"),
    League(id: 2015, name: "Ligue 1", code: "FL1", emblem: "https://crests.football-data.org/FL1.png", country: "France"),
    League(id: 2002, name: "Bundesliga", code: "BL1", emblem: "https://crests.football-data.org/BL1.png", country: "Germany"),
    League(id: 2019, name: "Serie A", code: "SA", emblem: "https://crests.football-data.org/SA.png", country: "Italy"),
    League(id: 2003, name: "Eredivisie", code: "DED", emblem: "https://crests.football-data.org/ED.png", country: "Netherlands"),
    League(id: 2017, name: "Primeira Liga", code: "PPL", emblem: "https://crests.football-data.org/PPL.png", country: "Portugal"),
    League(id: 2014, name: "Primera División", code: "PD", emblem: "https://crests.football-data.org/laliga.png", country: "Spain")
]



class TeamsClient
{
    static let shared = TeamsClient()
    
    private(set) var teams: [Team] = []
    private(set) var players: [Player] = []
    private(set) var coaches: [Coach] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    
    public static func getLeagues() -> [League]
    {
        return leagueList
    }
    
    public func configureLists() async
    {
        self.isLoading = true
        
        var fetchedTeams : [Team] = []
        var fetchedPlayers : [Player] = []
        var fetchedCoaches : [Coach] = []
        
        for league in leagueList
        {
            let stringURL = "https://api.football-data.org/v4/competitions/\(league.code)/teams"
            let components = URLComponents(string: stringURL)!
            let url = components.url!
            
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.setValue("d804ee3b8c8b43d3bc360ba3bf29f40d", forHTTPHeaderField: "X-Auth-Token")
            
            
            do
            {
                let (data, _) = try await session.data(for: request)
                let decoder = JSONDecoder()
                let response = try decoder.decode(TeamResponse.self, from: data)
                for team in response.teams
                {
                    fetchedTeams.append(team)
                    for player in team.squad
                    {
                        fetchedPlayers.append(Player(result: player, team: team))
                    }
                    fetchedCoaches.append(Coach(result: team.coach!, team: team))
                }
            }
            catch
            {
                self.errorMessage = "Failed fetching data: \(error.localizedDescription)"
                print("Error parsing JSON: \(error)")
            }
            
            self.teams = fetchedTeams
            self.players = fetchedPlayers
            self.coaches = fetchedCoaches
            
            /*
            for team in fetchedTeams
            {
                print("Team: \(team.name)")
            }
            
            for player in fetchedPlayers
            {
                print("Player: \(player.result.name)")
            }
            
            for coach in fetchedCoaches
            {
                print("Coach: \(coach.result.name)")
            }
             */
            self.isLoading = false
        }
        
    }
    
    
    
}
