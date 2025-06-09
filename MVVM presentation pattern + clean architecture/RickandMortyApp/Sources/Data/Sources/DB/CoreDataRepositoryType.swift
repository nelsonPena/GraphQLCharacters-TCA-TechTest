//
//  CoreDataRepositoryType.swift
//  RickAndMortyApp
//
//  Created by Nelson Peña Agudelo on 8/06/25.
//

import Foundation
import CoreData
import Combine

@available(iOS 13.0, *)
public protocol CoreDataRepositoryType: AnyObject {
    var savedCharactersPublisher: Published<[CharactersEntity]>.Publisher { get }
    func addCharacters(characters: [CharactersEntity])
    func delete(_ CharactersToDelete: CharactersEntity)
    func deleteAll()
    func getContext() -> NSManagedObjectContext
}
