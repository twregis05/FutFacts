//
//  TeamResponse.swift
//  FutFacts
//
//  Created by Trenton Regis on 8/20/25.
//

struct TRCoach: Codable
{
    let id: Int
    let firstName: String?
    let lastName: String?
    let name: String
    let dateOfBirth: String?
    let nationality: String
    let contract: TRContract?
}

struct TRContract: Codable
{
    let start: String?
    let until: String?
}

struct Coach
{
    let result: TRCoach
    let team: Team
}

struct TRPlayer: Codable
{
    let id: Int
    let name: String
    let position: String?
    let dateOfBirth: String?
    let nationality: String
}

struct TRArea: Codable
{
    let id: Int
    let name: String
    let code: String?
    let flag: String?
}

struct Player
{
    let result: TRPlayer
    let team: Team
}

struct Team: Codable
{
    let area: TRArea
    let id: Int
    let name: String
    let shortName: String
    let tla: String
    let crest: String?
    let website: String?
    let founded: Int?
    let venue: String
    let runningCompetitions: [TRCompetition]
    let coach: TRCoach?
    let squad: [TRPlayer]
}

struct TRCompetition: Codable
{
    let id: Int
    let name: String
    let code: String
    let type: String
    let emblem: String?
}

struct TeamResponse: Codable
{
    let count: Int
    let competition: TRCompetition
    let teams: [Team]
}


