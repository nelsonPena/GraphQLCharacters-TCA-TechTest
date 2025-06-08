//
//  Characters.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation

enum CharactersDTO {
    // MARK: - CharactersDTO
    struct ResponseDTO: Codable {
        let results: [ResultDTO]
    }
    
    // MARK: - Result
    struct ResultDTO: Codable {
        let id: Int
        let name: String
        let status: StatusDTO
        let species: SpeciesDTO
        let type: String
        let gender: GenderDTO
        let origin, location: LocationDTO
        let image: String 
        let url: String
        let created: String
    }
    
    enum GenderDTO: String, Codable {
        case female = "Female"
        case male = "Male"
        case unknown = "unknown"
    }
    
    // MARK: - Location
    struct LocationDTO: Codable {
        let name: String
        let url: String
    }
    
    enum SpeciesDTO: String, Codable {
        case alien = "Alien"
        case human = "Human"
    }
    
    enum StatusDTO: String, Codable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
}

extension CharactersDTO.ResultDTO {
    func mapper() -> Characters.Result {
        .init(id: self.id,
              name: self.name,
              status: Characters.Status(rawValue: self.status.rawValue) ?? .unknown,
              species: Characters.Species(rawValue: self.species.rawValue) ?? .human,
              type: self.type,
              gender: Characters.Gender(rawValue: self.gender.rawValue) ?? .unknown,
              origin: Characters.Location(name: self.origin.name, url: self.origin.url),
              location: Characters.Location(name: self.location.name, url: self.location.url),
              image: self.image,
              url: self.url,
              created: self.created)
    }
}
