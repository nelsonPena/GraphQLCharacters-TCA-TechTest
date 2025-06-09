//
//  CharactersRepositoryType.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation
import Combine
import Entities

@available(iOS 13.0, *)
public protocol CharactersRepositoryType: AnyObject {
    func getCharacters() -> AnyPublisher<Characters.Response, DomainError>
}
