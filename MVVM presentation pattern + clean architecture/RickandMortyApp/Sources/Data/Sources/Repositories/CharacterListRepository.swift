//
//  CharactersListRepository.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation
import Combine
import RepositoryProtocol
import Entities
import NetworkCore


/// `CharacterListRepository` es un repositorio que gestiona la obtención y eliminación de los personajes  utilizando un origen de datos de API.

@available(iOS 13.0, *)
public class CharacterListRepository: CharactersRepositoryType {
    
    private let apiDataSource: CharacterAPIListDataSourceType
    
    /// Inicializa una nueva instancia de `CharacterListRepository` con un origen de datos de API personalizado.
    ///
    /// - Parameters:
    ///   - apiDataSource: El origen de datos de API que se utilizará para obtener  los personajes .
    public init(apiDataSource: CharacterAPIListDataSourceType) {
        self.apiDataSource = apiDataSource
    }
    
    /// Obtiene una lista de los personajes  y las mapea a objetos `Character` utilizando Combine.
    ///
    /// - Returns: Un editor de AnyPublisher que emite una lista de los personajes  o un error de `DomainError`.
    public func getCharacters() -> AnyPublisher<Characters.Response, DomainError> {
        let response: AnyPublisher<CharactersDTO.ResponseDTO, HttpClientError> = apiDataSource.GetCharactersList()
        return response
            .map { .init(results: $0.results.map{ $0.mapper() }) }
            .mapError { $0.map() }
            .eraseToAnyPublisher()
    }
}
