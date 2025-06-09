//
//  File.swift
//  Domain
//
//  Created by Nelson Peña Agudelo on 8/06/25.
//

import Foundation
import Entities
import Combine

@available(iOS 13.0, *)
public protocol GetDataProviderType: AnyObject {
    var savedCharactersPublisher: Published<[SavedCharacter]>.Publisher { get }
    func addCharacters(characters: [SavedCharacter])
    func delete(_ CharactersToDelete: SavedCharacter)
    func deleteAll()
}
