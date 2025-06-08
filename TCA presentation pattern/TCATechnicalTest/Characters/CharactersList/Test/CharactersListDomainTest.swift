//
//  CharactersListDomainTest.swift
//  TCA Technical Test
//
//  Created by Nelson Peña Agudelo on 6/06/25.
//

import XCTest
import ComposableArchitecture

@testable import TCATechnicalTest

@MainActor
final class CharacterListDomainTest: XCTestCase {

    override func setUp() async throws {
        UUID.uuIdTestCounter = 0
    }

    func testFetchCharactersSuccess() async {
        let characters = Character.sample

        let store = TestStore(
            initialState: CharacterListDomain.State(),
            reducer: { CharacterListDomain() }
        ) {
            $0.apiClient.fetchCharacters = { characters }
            $0.uuid = .incrementing
        }

        let expectedList = IdentifiedArray(uniqueElements: characters.enumerated().map { index, character in
            CharacterItemDomain.State(id: UUID.newUUIDForTest, character: character)
        })

        await store.send(.fetchCharacters) {
            $0.dataLoadingStatus = .loading
        }

        await store.receive(
            .fetchCharactersResponse(.success(characters))
        ) {
            $0.characterList = expectedList
            $0.filteredList = expectedList
            $0.dataLoadingStatus = .success
        }
    }

    func testFetchCharactersFailure() async {
        let error = APIClient.Failure()
        let store = TestStore(
            initialState: CharacterListDomain.State(),
            reducer: { CharacterListDomain() }
        ) {
            $0.apiClient.fetchCharacters = { throw error }
            $0.uuid = .incrementing
        }

        await store.send(.fetchCharacters) {
            $0.dataLoadingStatus = .loading
        }

        await store.receive(.fetchCharactersResponse(.failure(error))) {
            $0.dataLoadingStatus = .error
        }
    }

    func testSearchCharacters() async {
        let characters = Character.sample

        let store = TestStore(
            initialState: CharacterListDomain.State(),
            reducer: { CharacterListDomain() }
        ) {
            $0.apiClient.fetchCharacters = { characters }
            $0.uuid = .incrementing
        }

        let fullList = IdentifiedArray(uniqueElements: characters.enumerated().map { index, character in
            CharacterItemDomain.State(id: UUID.newUUIDForTest, character: character)
        })

        await store.send(.fetchCharacters) {
            $0.dataLoadingStatus = .loading
        }

        await store.receive(.fetchCharactersResponse(.success(characters))) {
            $0.characterList = fullList
            $0.filteredList = fullList
            $0.dataLoadingStatus = .success
        }

        await store.send(.searchTextChanged("Morty")) {
            $0.searchText = "Morty"
            $0.filteredList = IdentifiedArray(uniqueElements: fullList.filter { $0.character.name.contains("Morty") })
        }

        await store.send(.searchTextChanged("")) {
            $0.searchText = ""
            $0.filteredList = fullList
        }
    }

    func testSetAndCloseCharacterDetail() async {
        let character = Character.sample[0]
        let detailState = CharacterDetailDomain.State(character: CharacterDetail(from: character))

        let store = TestStore(
            initialState: CharacterListDomain.State(),
            reducer: { CharacterListDomain() }
        )

        await store.send(.setDetailView(isPresented: true, character: character)) {
            $0.characterDetail = detailState
        }

        await store.send(.detail(.presented(.didPressCloseButton))) {
            $0.characterDetail = nil
        }
    }
}

extension UUID {
    static var uuIdTestCounter: UInt = 0
    static var newUUIDForTest: UUID {
        defer { uuIdTestCounter += 1 }
        return UUID(uuidString: "00000000-0000-0000-0000-\(String(format: "%012x", uuIdTestCounter))")!
    }
}
