//
//  CharacterListPresentableItem+SavedCharacter.swift
//  RickAndMortyApp
//
//  Created by Nelson Peña Agudelo on 8/06/25.
//

import Foundation
import Entities

extension CharacterListPresentableItem {
    func mapToSavedCharacter() -> SavedCharacter {
        return SavedCharacter(
            characterId: self.id,
            id: UUID(), // Se genera un nuevo UUID local para persistencia
            name: self.name,
            species: self.species,
            gender: self.gender,
            originName: self.originName,
            locationName: self.locationName,
            image: self.image,
            created: self.created,
            status: self.status
        )
    }
}
