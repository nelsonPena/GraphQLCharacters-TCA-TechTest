//
//  File.swift
//  Domain
//
//  Created by Nelson Peña Agudelo on 8/06/25.
//

import Quick
import Nimble
import Combine
@testable import Entities
@testable import RepositoryProtocol
import Foundation

final class DataProviderRepositorySpec: QuickSpec {
    override func spec() {
        var repository: MockDataProviderRepositoryType!
        var cancellables: Set<AnyCancellable>!

        describe("DataProviderRepositoryType") {
            beforeEach {
                repository = MockDataProviderRepositoryType()
                cancellables = []
            }

            context("when savedCharactersPublisher emits values") {
                it("should emit mapped characters") {
                    let expectedCharacter = SavedCharacter(
                        characterId: "1",
                        id: UUID(),
                        name: "Rick",
                        species: "Human",
                        gender: "Male",
                        originName: "Earth",
                        locationName: "Citadel",
                        image: "url",
                        created: "today",
                        status: "Alive"
                    )

                    var receivedCharacters: [SavedCharacter] = []

                    repository.savedCharactersPublisher
                        .sink(receiveCompletion: { _ in }, receiveValue: { characters in
                            receivedCharacters = characters
                        })
                        .store(in: &cancellables)

                    repository.characters = [expectedCharacter]

                    await expect(receivedCharacters).toEventually(equal([expectedCharacter]))
                }
            }

            context("when calling addCharacters") {
                it("stores the characters") {
                    let characters = [SavedCharacter(characterId: "2", id: UUID(), name: "Morty", species: "Human", gender: "Male", originName: "Earth", locationName: "Citadel", image: "url", created: "today", status: "Alive")]

                    repository.addCharacters(characters: characters)

                    expect(repository.addedCharacters).to(equal(characters))
                }
            }

            context("when calling delete") {
                it("deletes the correct character") {
                    let character = SavedCharacter(characterId: "3", id: UUID(), name: "Summer", species: "Human", gender: "Female", originName: "Earth", locationName: "Citadel", image: "url", created: "today", status: "Alive")

                    repository.delete(character)

                    expect(repository.deletedCharacter?.id).to(equal(character.id))
                }
            }

            context("when calling deleteAll") {
                it("sets didCallDeleteAll to true") {
                    repository.deleteAll()

                    expect(repository.didCallDeleteAll).to(beTrue())
                }
            }
        }
    }
}
