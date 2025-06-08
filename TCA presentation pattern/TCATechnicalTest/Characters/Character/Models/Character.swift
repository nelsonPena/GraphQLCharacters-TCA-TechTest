//
//  Character.swift
//  TCA Technical Test
//
//  Created by Nelson Peña Agudelo on 6/06/25.
//

import Foundation

struct GraphQLCharactersResponse: Codable {
    let data: CharactersData
}

struct CharactersData: Codable {
    let characters: CharactersResults
}

struct CharactersResults: Codable {
    let results: [Character]
}

// MARK: - Character Model
struct Character: Equatable{
    let name: String
    let species: String
    let gender: String
    let originName: String
    let locationName: String
    let image: String
    let created: String
    let status: String
}

extension Character: Codable {
    // Custom decoding to map nested fields from GraphQL
    private enum CharacterItemsKey: String, CodingKey {
        case name, status, species, gender, origin, location, image, url, created
    }
    
    private enum NestedLocationKeys: String, CodingKey {
        case name
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CharacterItemsKey.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
        self.created = try container.decode(String.self, forKey: .created)
        
        let status = try container.decode(Status.self, forKey: .status)
        self.status = status.map()
        
        let species = try container.decode(Species.self, forKey: .species)
        self.species = species.map()
        
        let gender = try container.decode(Gender.self, forKey: .gender)
        self.gender = gender.map()
        
        // Decode nested origin
        let originContainer = try container.nestedContainer(keyedBy: NestedLocationKeys.self, forKey: .origin)
        self.originName = try originContainer.decode(String.self, forKey: .name)
        
        
        // Decode nested location
        let locationContainer = try container.nestedContainer(keyedBy: NestedLocationKeys.self, forKey: .location)
        self.locationName = try locationContainer.decode(String.self, forKey: .name)
    }
}

extension GraphQLCharactersResponse {
    static var sample: GraphQLCharactersResponse {
        GraphQLCharactersResponse(
            data: CharactersData(
                characters: CharactersResults(
                    results: Character.sample
                )
            )
        )
    }
}

extension Character {
    static var sample: [Character] {
        [
            Character(
                name: "Rick Sanchez",
                species: "Human",
                gender: "Male",
                originName: "Earth (C-137)",
                locationName: "Citadel of Ricks",
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                created: "2017-11-04T18:48:46.250Z",
                status: "Alive"
            ),
            Character(
                name: "Morty Smith",
                species: "Human",
                gender: "Male",
                originName: "Earth (C-137)",
                locationName: "Citadel of Ricks",
                image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                created: "2017-11-04T18:50:21.651Z",
                status: "Alive"
            )
        ]
    }
}
