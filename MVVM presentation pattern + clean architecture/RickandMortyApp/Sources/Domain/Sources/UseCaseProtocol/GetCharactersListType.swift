//
//  File.swift
//  Domain
//
//  Created by Nelson Peña Agudelo on 8/06/25.
//

import Foundation
import Combine
import Entities

/// `GetCharactersListType` es un protocolo de la capa de dominio que define métodos para obtener los personajes .

@available(iOS 13.0, *)
public protocol GetCharactersListType: AnyObject {
    
    /// Obtiene una lista de los personajes  y emite un editor de AnyPublisher que puede contener una lista de los personajes  o un error de `DomainError`.
    func getCharacters() -> AnyPublisher<Characters.Response, DomainError>
}
