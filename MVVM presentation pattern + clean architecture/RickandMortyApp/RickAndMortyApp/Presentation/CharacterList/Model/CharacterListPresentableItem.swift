//
//  CharacterListPresentableItem.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation

struct CharacterListPresentableItem {
    
    let id: String
    let name: String
    let species: String
    let gender: String
    let originName: String
    let locationName: String
    let image: String
    let created: String
    let status: String
    
    internal init(domainModel: Characters.Result) {
        self.id = domainModel.id.description
        self.name = domainModel.name
        self.species = domainModel.species.map(species: domainModel.species)
        self.gender = domainModel.gender.map(gender: domainModel.gender)
        self.originName = domainModel.origin.name
        self.locationName = domainModel.location.name
        self.image = domainModel.image
        self.created = domainModel.created
        self.status = domainModel.status.map(status: domainModel.status)
    }
    
    internal init(savedModel: SavedCharacters) {
        self.id = savedModel.characterId
        self.name = savedModel.name
        self.species = savedModel.species
        self.gender = savedModel.gender
        self.originName = savedModel.originName
        self.locationName = savedModel.locationName
        self.image = savedModel.image
        self.created = savedModel.created
        self.status = savedModel.status
    }
}

