//
//  File.swift
//  Data
//
//  Created by Nelson Peña Agudelo on 8/06/25.
//

import Quick
import Nimble
import Combine
import Foundation
@testable import RepositoryProtocol
@testable import Repositories
@testable import NetworkCore

final class MockCharacterAPIListDataSourceType: CharacterAPIListDataSourceType {
    var result: Result<CharactersDTO.ResponseDTO, HttpClientError> = .success(
        CharactersDTO.ResponseDTO(results: [])
    )

    func GetCharactersList() -> AnyPublisher<CharactersDTO.ResponseDTO, HttpClientError> {
        return result.publisher.eraseToAnyPublisher()
    }
}
