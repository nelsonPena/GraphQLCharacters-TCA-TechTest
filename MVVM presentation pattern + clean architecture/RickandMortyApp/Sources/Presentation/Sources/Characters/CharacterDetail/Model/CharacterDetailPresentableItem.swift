//
//  CharacterDetailPresentableItem.swift
//  RickAndMortyApp
//
//  Created by Nelson Peña Agudelo on 6/06/25.
//

import Foundation
import Entities
import Helpers

public struct CharacterDetailPresentableItem {
   
    public init(id: String, name: String, species: String, gender: String, originName: String, locationName: String, image: String, created: String, status: String) {
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
    
    internal init(savedModel: SavedCharacter) {
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
    
    internal init(presentableListModel: CharacterListPresentableItem) {
        self.id = presentableListModel.id
        self.name = presentableListModel.name
        self.species = presentableListModel.species
        self.gender = presentableListModel.gender
        self.originName = presentableListModel.originName
        self.locationName = presentableListModel.locationName
        self.image = presentableListModel.image
        self.created = presentableListModel.created
        self.status = presentableListModel.status
    }
}


