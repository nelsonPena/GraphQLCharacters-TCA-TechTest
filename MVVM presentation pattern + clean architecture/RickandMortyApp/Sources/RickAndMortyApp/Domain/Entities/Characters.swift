//
//  TheRickAndMortyApp.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation

enum Characters {
  
    struct Response {
        let results: [Result]
    }

    // MARK: - Result
    struct Result {
        let id: Int
        let name: String
        let status: Status
        let species: Species
        let type: String
        let gender: Gender
        let origin, location: Location
        let image: String
        let url: String
        let created: String
    }

    enum Gender: String {
        case female = "Female"
        case male = "Male"
        case unknown = "unknown"
    }

    // MARK: - Location
    struct Location {
        let name: String
        let url: String
    }

    enum Species: String {
        case alien = "Alien"
        case human = "Human"
    }

    enum Status: String {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }

}

extension Characters.Gender {
    func map(gender: Characters.Gender) -> String {
        switch gender {
        case .female:
            "text_female_gender".localized
        case .male:
            "text_male_gender".localized
        case .unknown:
            "text_unknown_gender".localized
        }
    }
}

extension Characters.Species {
    func map(species: Characters.Species) -> String {
        switch species {
        case .alien:
            "text_alien_species".localized
        case .human:
            "text_human_species".localized
        } 
    }
}

extension Characters.Status {
    func map(status: Characters.Status) -> String {
        switch status {
        case .alive:
            "text_alive_status".localized
        case .dead:
            "text_dead_status".localized
        case .unknown:
            "text_unknown_status".localized
        }
    }
}

// MARK: Test

extension Characters.Result: Equatable {
    public static func == (lhs: Characters.Result, rhs: Characters.Result) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.status == rhs.status &&
               lhs.species == rhs.species &&
               lhs.type == rhs.type &&
               lhs.gender == rhs.gender &&
               lhs.origin == rhs.origin &&
               lhs.location == rhs.location &&
               lhs.image == rhs.image &&
               lhs.url == rhs.url &&
               lhs.created == rhs.created
    }
}

extension Characters.Response: Equatable {
    public static func == (lhs: Characters.Response, rhs: Characters.Response) -> Bool {
        return lhs.results == rhs.results
    }
}

extension Characters.Location: Equatable {
    public static func == (lhs: Characters.Location, rhs: Characters.Location) -> Bool {
        return lhs.name == rhs.name && lhs.url == rhs.url
    }
}

