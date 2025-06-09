//
//  GetCharacters.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import UIKit
import Combine

/// `GetCharactersListType` es un protocolo de la capa de dominio que define métodos para obtener los personajes .

protocol GetCharactersListType: AnyObject {
    
    /// Obtiene una lista de los personajes  y emite un editor de AnyPublisher que puede contener una lista de los personajes  o un error de `DomainError`.
    func getCharacters() -> AnyPublisher<Characters.Response, DomainError>
}

/// `GetCharacters` es una clase de la capa de dominio que implementa el protocolo `GetCharactersListType` para obtener  los personajes .

class GetCharacters {
    private var repository: CharactersRepositoryType?
    
    /// Inicializa una nueva instancia de `GetCharacters` con un repositorio personalizado.
    ///
    /// - Parameters:
    ///   - repository: El repositorio que se utilizará para obtener  los personajes .
    init(repository: CharactersRepositoryType) {
        self.repository = repository
    }
}

extension GetCharacters: GetCharactersListType {
    
    /// Obtiene una lista de los personajes  utilizando el repositorio y emite un editor de AnyPublisher que puede contener una lista de los personajes  o un error de `DomainError`.
    ///
    /// - Returns: Un editor de AnyPublisher que emite una lista de los personajes  o un error de `DomainError`.
    func getCharacters() ->  AnyPublisher<Characters.Response, DomainError> {
        guard let repository = repository else {
            return Fail(error: DomainError.generic).eraseToAnyPublisher()
        }
        return repository.getCharacters()
    }
}
