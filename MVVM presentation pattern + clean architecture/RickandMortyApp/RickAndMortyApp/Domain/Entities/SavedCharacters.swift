//
//  DelectedCharacters.swift
//  TheRickAndMorty
//
//  Created by Nelson Geovanny Pena Agudelo on 15/10/23.
//

import Foundation

struct SavedCharacters {
    let characterId: String
    let id: UUID
    let name: String
    let species: String
    let gender: String
    let originName: String
    let locationName: String
    let image: String
    let created: String
    let status: String
}

extension SavedCharacters {
    func mapper() -> CharacterListPresentableItem {
        .init(savedModel: self)
    }
}
