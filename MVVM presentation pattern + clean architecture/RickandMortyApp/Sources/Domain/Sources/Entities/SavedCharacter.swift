//
//  DelectedCharacters.swift
//  TheRickAndMorty
//
//  Created by Nelson Geovanny Pena Agudelo on 15/10/23.
//

import Foundation

public struct SavedCharacter {
   
    public init(characterId: String, id: UUID, name: String, species: String, gender: String, originName: String, locationName: String, image: String, created: String, status: String) {
        self.characterId = characterId
        self.id = id
        self.name = name
        self.species = species
        self.gender = gender
        self.originName = originName
        self.locationName = locationName
        self.image = image
        self.created = created
        self.status = status
    }

    
    public let characterId: String
    public let id: UUID
    public let name: String
    public let species: String
    public let gender: String
    public let originName: String
    public let locationName: String
    public let image: String
    public let created: String
    public let status: String
}


