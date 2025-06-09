//
//  DataProviderType.swift
//  TheRickAndMorty
//
//  Created by Nelson Geovanny Pena Agudelo on 15/10/23.
//

import Foundation
import Combine
import Entities

@available(iOS 13.0, *)
public protocol DataProviderRepositoryType: AnyObject {
    var savedCharactersPublisher: Published<[SavedCharacter]>.Publisher { get }
    func addCharacters(characters: [SavedCharacter])
    func delete(_ CharactersToDelete: SavedCharacter)
    func deleteAll()
}
