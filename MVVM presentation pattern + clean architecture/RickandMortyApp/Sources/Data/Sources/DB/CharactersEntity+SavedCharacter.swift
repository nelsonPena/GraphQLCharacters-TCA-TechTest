//
//  CharactersEntity+SavedCharacter.swift
//  RickAndMortyApp
//
//  Created by Nelson Peña Agudelo on 8/06/25.
//

import Foundation
import CoreData
import Entities

extension CharactersEntity {
 
    public func mapToSavedCharacter() -> SavedCharacter {
        return SavedCharacter(
                   characterId: self.characterId,
                   id: self.id,
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
