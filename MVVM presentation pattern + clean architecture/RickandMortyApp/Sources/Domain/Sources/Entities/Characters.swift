//
//  TheRickAndMortyApp.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation

public enum Characters {
  
    public struct Response {
       
        public init(results: [Characters.Result]) {
            self.results = results
        }
    
        public let results: [Result]
    }

    // MARK: - Result
    public struct Result {
        
        public init(id: Int, name: String, status: Characters.Status, species: Characters.Species, type: String, gender: Characters.Gender, origin: Characters.Location, location: Characters.Location, image: String, url: String, created: String) {
            self.id = id
            self.name = name
            self.status = status
            self.species = species
            self.type = type
            self.gender = gender
            self.origin = origin
            self.location = location
            self.image = image
            self.url = url
            self.created = created
        }
        
        public let id: Int
        public let name: String
        public let status: Status
        public let species: Species
        public let type: String
        public let gender: Gender
        public let origin, location: Location
        public let image: String
        public let url: String
        public let created: String
    }

    public enum Gender: String {
        case female = "Female"
        case male = "Male"
        case unknown = "unknown"
    }

    // MARK: - Location
    public struct Location {
        public init(name: String, url: String) {
            self.name = name
            self.url = url
        }
        
        public let name: String
        public let url: String
    }

    public enum Species: String {
        case alien = "Alien"
        case human = "Human"
    }

    public enum Status: String {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
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

