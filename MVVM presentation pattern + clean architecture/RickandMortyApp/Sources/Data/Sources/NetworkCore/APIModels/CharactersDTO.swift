//
//  Characters.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation
import Entities

public enum CharactersDTO {
    // MARK: - CharactersDTO
    public struct ResponseDTO: Codable {
        public let results: [ResultDTO]
    }
    
    // MARK: - Result
    public struct ResultDTO: Codable {
        public let id: Int
        public let name: String
        public let status: StatusDTO
        public let species: SpeciesDTO
        public let type: String
        public let gender: GenderDTO
        public let origin, location: LocationDTO
        public let image: String
        public let url: String
        public let created: String
    }
    
    public enum GenderDTO: String, Codable {
        case female = "Female"
        case male = "Male"
        case unknown = "unknown"
    }
    
    // MARK: - Location
    public struct LocationDTO: Codable {
        public let name: String
        public let url: String
    }
    
    public enum SpeciesDTO: String, Codable {
        case alien = "Alien"
        case human = "Human"
    }
    
    public enum StatusDTO: String, Codable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
}

extension CharactersDTO.ResultDTO {
    public func mapper() -> Characters.Result {
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
