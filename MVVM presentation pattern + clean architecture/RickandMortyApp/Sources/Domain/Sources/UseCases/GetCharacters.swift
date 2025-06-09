//
//  GetCharacters.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import UIKit
import Combine
import Entities
import RepositoryProtocol
import UseCaseProtocol


/// `GetCharacters` es una clase de la capa de dominio que implementa el protocolo `GetCharactersListType` para obtener  los personajes .

@available(iOS 13.0, *)
public class GetCharacters {
    private var repository: CharactersRepositoryType?
    
    /// Inicializa una nueva instancia de `GetCharacters` con un repositorio personalizado.
    ///
    /// - Parameters:
    ///   - repository: El repositorio que se utilizará para obtener  los personajes .
    public init(repository: CharactersRepositoryType) {
        self.repository = repository
    }
}

@available(iOS 13.0, *)
extension GetCharacters: GetCharactersListType {
    
    /// Obtiene una lista de los personajes  utilizando el repositorio y emite un editor de AnyPublisher que puede contener una lista de los personajes  o un error de `DomainError`.
    ///
    /// - Returns: Un editor de AnyPublisher que emite una lista de los personajes  o un error de `DomainError`.
    public func getCharacters() ->  AnyPublisher<Characters.Response, DomainError> {
        guard let repository = repository else {
            return Fail(error: DomainError.generic).eraseToAnyPublisher()
        }
        return repository.getCharacters()
    }
}
