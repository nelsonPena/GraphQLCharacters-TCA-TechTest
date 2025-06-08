//
//  CharacterDetail.swift
//  TCATechnicalTest
//
//  Created by Nelson Peña Agudelo on 6/06/25.
//

import Foundation

struct CharacterDetail: Equatable {
    let name: String
    let species: String
    let gender: String
    let originName: String
    let locationName: String
    let image: String
    let created: String
    let status: String
}

extension CharacterDetail {
    internal init(from character: Character) {
        self.name = character.name
        self.species = character.species
        self.gender = character.gender
        self.originName = character.originName
        self.locationName = character.locationName
        self.image = character.image
        self.created = character.created
        self.status = character.status
    }
}

extension CharacterDetail {
    static let preview: CharacterDetail = CharacterDetail(
        name: "Rick Sanchez",
        species: "Human",
        gender: "Male",
        originName: "Earth (C-137)",
        locationName: "Citadel of Ricks",
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        created: "2017-11-04T18:48:46.250Z",
        status: "Alive"
    )
}
