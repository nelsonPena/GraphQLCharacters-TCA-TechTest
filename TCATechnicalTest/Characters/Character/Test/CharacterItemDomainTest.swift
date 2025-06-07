//
//  CharacterItemDomainTest.swift
//  TCATechnicalTest
//
//  Created by Nelson Peña Agudelo on 6/06/25.
//

import ComposableArchitecture
import XCTest

@testable import TCATechnicalTest

@MainActor
final class CharacterItemDomainTest: XCTestCase {
    func testTapCharacterItem() async {
        let character = Character(
            id: 1,
            name: "Rick Sanchez",
            species: "Human",
            gender: "Male",
            originName: "Earth (C-137)",
            locationName: "Citadel of Ricks",
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            created: "2017-11-04T18:48:46.250Z",
            status: "Alive"
        )

        let store = TestStore(
            initialState: CharacterItemDomain.State(
                id: UUID(),
                character: character
            ),
            reducer: { CharacterItemDomain() }
        )

        await store.send(.didTap)
    }
}
