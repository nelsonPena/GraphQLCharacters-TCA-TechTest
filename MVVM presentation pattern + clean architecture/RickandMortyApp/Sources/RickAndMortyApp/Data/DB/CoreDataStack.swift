//
//  CoreDataStack.swift
//  TheRickAndMorty
//
//  Created by Nelson Geovanny Pena Agudelo on 15/10/23.
//

import Foundation
import Combine
import CoreData

/// Gestiona el acceso y la manipulación de los datos almacenados en CoreData.
class CoreDataStack {
    
    /// El contexto de objetos administrados de CoreData.
    private var managedObjectContext: NSManagedObjectContext
    
    /// Conjunto de suscripciones a cambios en los datos de las los personajes  a eliminar.
    private var cancellables = Set<AnyCancellable>()
    
    /// Lista de los personajes  almacenadas en CoreData.
    @Published var Characters: [CharactersEntity] = []
    
    /// Inicializa una nueva instancia de CoreDataStack.
    /// - Parameter context: El contexto de objetos administrados de CoreData.
    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
        publish()
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    /// Obtiene todas las los personajes  almacenadas en CoreData.
    /// - Returns: Un array de objetos CharactersToDeleteEntity.
    private func allCharacters() -> [CharactersEntity] {
        do {
            let fetchRequest: NSFetchRequest<CharactersEntity> = CharactersEntity.fetchRequest()
            return try self.managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
            return []
        }
    }
    
    /// Guarda los cambios realizados en el contexto de CoreData.
    private func save() {
        do {
            try self.managedObjectContext.save()
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
        publish()
    }
    
    /// Publica la lista de los personajes .
    private func publish() {
        Characters = allCharacters()
    }
}

/// Extiende CoreDataStack para conformarla al protocolo DataProviderRepositoryType.
extension CoreDataStack: DataProviderRepositoryType {
    
    /// Publicador para la lista de los personajes  a eliminar.
    var savedCharactersPublisher: Published<[CharactersEntity]>.Publisher {
        $Characters
    }
    
    /// Agrega un nuevo personaje a la lista de los personajes  a eliminar.
    /// - Parameter CharacterId: El identificador de el personaje a agregar.
    func addCharacters(characters: [CharacterListPresentableItem]) {
        characters.forEach { characterItem in
            let character = CharactersEntity(context: managedObjectContext)
            character.id = UUID()
            character.characterId = String(characterItem.id)
            character.name = characterItem.name
            character.gender = characterItem.gender
            character.originName = characterItem.originName
            character.species = characterItem.species
            character.image = characterItem.image
            character.locationName = characterItem.locationName
            character.created = characterItem.created
            character.status = characterItem.status
            save()
        }
    }
    
    /// Elimina un personaje de la lista de los personajes  a eliminar.
    /// - Parameter Character: el personaje a eliminar.
    func delete(_ Character: CharactersEntity) {
        self.managedObjectContext.delete(Character)
        save()
    }
    
    /// Elimina todas las los personajes  de la lista de los personajes  a eliminar.
    func deleteAll() {
        allCharacters().forEach { object in
            managedObjectContext.delete(object)
        }
        save()
    }
}
