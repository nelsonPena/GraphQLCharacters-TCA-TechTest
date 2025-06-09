//
//  File.swift
//  Domain
//
//  Created by Nelson Peña Agudelo on 8/06/25.
//

import Quick
import Nimble
import Combine
import RepositoryProtocol
import Entities

final class MockDataProviderRepositoryType: DataProviderRepositoryType {
    @Published var characters: [SavedCharacter] = []
    var addedCharacters: [SavedCharacter] = []
    var deletedCharacter: SavedCharacter?
    var didCallDeleteAll = false

    var savedCharactersPublisher: Published<[SavedCharacter]>.Publisher {
        $characters
    }

    func addCharacters(characters: [SavedCharacter]) {
        addedCharacters = characters
    }

    func delete(_ character: SavedCharacter) {
        deletedCharacter = character
    }

    func deleteAll() {
        didCallDeleteAll = true
    }
}

final class MockCharactersRepositoryType: CharactersRepositoryType {
    var getCharactersResult: Result<Characters.Response, DomainError> = .failure(.generic)

    func getCharacters() -> AnyPublisher<Characters.Response, DomainError> {
        return getCharactersResult.publisher.eraseToAnyPublisher()
    }
}
