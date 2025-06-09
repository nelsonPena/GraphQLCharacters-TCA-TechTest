//
//  CharactersListRepository.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation
import Combine

/// `CharacterListRepository` es un repositorio que gestiona la obtención y eliminación de los personajes  utilizando un origen de datos de API.

class CharacterListRepository: CharactersRepositoryType {
    
    private let apiDataSource: ApiCharacterListDataSourceType
    
    /// Inicializa una nueva instancia de `CharacterListRepository` con un origen de datos de API personalizado.
    ///
    /// - Parameters:
    ///   - apiDataSource: El origen de datos de API que se utilizará para obtener  los personajes .
    init(apiDataSource: ApiCharacterListDataSourceType) {
        self.apiDataSource = apiDataSource
    }
    
    /// Obtiene una lista de los personajes  y las mapea a objetos `Character` utilizando Combine.
    ///
    /// - Returns: Un editor de AnyPublisher que emite una lista de los personajes  o un error de `DomainError`.
    func getCharacters() -> AnyPublisher<Characters.Response, DomainError> {
        let response: AnyPublisher<CharactersDTO.ResponseDTO, HttpClientError> = apiDataSource.GetCharactersList()
        return response
            .map { .init(results: $0.results.map{ $0.mapper() }) }
            .mapError { $0.map() }
            .eraseToAnyPublisher()
    }
}
