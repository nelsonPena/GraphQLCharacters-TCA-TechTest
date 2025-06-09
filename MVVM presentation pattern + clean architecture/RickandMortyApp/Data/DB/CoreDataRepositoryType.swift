//
//  CoreDataRepositoryType.swift
//  RickAndMortyApp
//
//  Created by Nelson Peña Agudelo on 8/06/25.
//

import Foundation
import CoreData

protocol CoreDataRepositoryType: AnyObject {
    var savedCharactersPublisher: Published<[CharactersEntity]>.Publisher { get }
    func addCharacters(characters: [CharactersEntity])
    func delete(_ CharactersToDelete: CharactersEntity)
    func deleteAll()
    func getContext() -> NSManagedObjectContext
}
