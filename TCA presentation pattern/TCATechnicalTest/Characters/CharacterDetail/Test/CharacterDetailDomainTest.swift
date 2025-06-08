//
//  CharacterDetailDomain.swift
//  TCATechnicalTest
//
//  Created by Nelson Peña Agudelo on 6/06/25.
//

import XCTest
import ComposableArchitecture

@testable import TCATechnicalTest

@MainActor
final class CharacterDetailDomainTest: XCTestCase {
    func testDidPressCloseButton() async {
        let characterDetail = CharacterDetail(
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
            initialState: CharacterDetailDomain.State(character: characterDetail),
            reducer: { CharacterDetailDomain() }
        )

        await store.send(.didPressCloseButton)
    }
}
