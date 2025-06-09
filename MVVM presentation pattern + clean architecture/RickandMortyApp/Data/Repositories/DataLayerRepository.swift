//
//  DataLayer.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation
import Combine
import Entities
import RepositoryProtocol


/// `DataLayerRepository` es un repositorio de capa de datos que gestiona la interacción con los datos de personajes en la capa de persistencia.

class DataLayerRepository {
    
    private weak var dataProvider: CoreDataStack?
    private var cancellables = Set<AnyCancellable>()
    
    /// Una matriz de personajes presentados como entidades de la capa de persistencia.
    @Published var characters: [SavedCharacter] = []
    
    /// Inicializa una nueva instancia de `DataLayerRepository` con un proveedor de datos de capa de persistencia.
    ///
    /// - Parameters:
    ///   - provider: El proveedor de datos de capa de persistencia que se utilizará para interactuar con los datos de los personajes  a eliminar.
    init(provider: CoreDataStack) {
        self.dataProvider = provider
        setup()
    }
    
    // MARK: Private functions
    private func setup() {
        guard let dataProvider else { return }
        
        dataProvider.savedCharactersPublisher
            .sink { [weak self] characters in
                self?.characters = characters.map{ $0.mapToSavedCharacter() }
            }
            .store(in: &cancellables)
    }
    

    
    /// Elimina todas los personajes.
    func deleteAllCharacters() {
      
    }
}

extension DataLayerRepository: DataProviderRepositoryType {
    
    var savedCharactersPublisher: Published<[SavedCharacter]>.Publisher {
        $characters
    }
    
    /// Agrega un nuevo personaje a la lista de los personajes  a eliminar.
    /// - Parameter characters: El identificador de el personaje a agregar.
    func addCharacters(characters: [SavedCharacter]) {
        guard let dataProvider else { return }
        dataProvider.addCharacters(characters: characters.map{ .init(context: dataProvider.getContext(), savedCharacter: $0)  })
    }
    
    /// Elimina un personaje de la lista de los personajes  a eliminar.
    /// - Parameter Character: el personaje a eliminar.
    func delete(_ character: SavedCharacter) {
        guard let dataProvider else { return }
        dataProvider.delete(CharactersEntity(context: dataProvider.getContext(), savedCharacter: character))
    }
    
    /// Elimina todas las los personajes  de la lista de los personajes  a eliminar.
    func deleteAll() {
        guard let dataProvider else { return }
        dataProvider.deleteAll()
    }
}
