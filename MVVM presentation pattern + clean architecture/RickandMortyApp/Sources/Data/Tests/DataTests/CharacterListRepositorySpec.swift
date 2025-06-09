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
import Entities
@testable import RepositoryProtocol
@testable import Repositories
@testable import NetworkCore

final class CharacterListRepositorySpec: QuickSpec {
    override func spec() {
        var repository: CharacterListRepository!
        var apiDataSource: MockCharacterAPIListDataSourceType!
        var cancellables: Set<AnyCancellable>!

        describe("CharacterListRepository") {

            beforeEach {
                apiDataSource = MockCharacterAPIListDataSourceType()
                repository = CharacterListRepository(apiDataSource: apiDataSource)
                cancellables = []
            }

            context("when the API data source returns success") {
                it("should return mapped characters") {
                    let dto = CharactersDTO.ResponseDTO(
                        results: [
                            CharactersDTO
                                .ResultDTO(
                                    id: 1,
                                    name: "Rick",
                                    status: .alive,
                                    species: .human,
                                    type: "type",
                                    gender: .male,
                                    origin: .init(
                                        name: "Earth",
                                        url: "url"
                                    ),
                                    location: .init(
                                        name: "Earth",
                                        url: "url"
                                    ),
                                    image: "url",
                                    url: "url",
                                    created: "date"
                                )
                        ]
                    )
                    apiDataSource.result = .success(dto)

                    var result: Characters.Response?

                    repository.getCharacters()
                        .sink(receiveCompletion: { _ in }, receiveValue: { value in
                            result = value
                        })
                        .store(in: &cancellables)

                    await expect(result?.results.first?.name).toEventually(equal("Rick"))
                }
            }

            context("when the API data source returns an error") {
                it("should map and return DomainError") {
                    apiDataSource.result = .failure(.timeOut)

                    var receivedError: DomainError?

                    repository.getCharacters()
                        .sink(receiveCompletion: { completion in
                            if case let .failure(error) = completion {
                                receivedError = error
                            }
                        }, receiveValue: { _ in })
                        .store(in: &cancellables)

                    await expect(receivedError).toEventually(equal(DomainError.timeOut))
                }
            }
        }
    }
}
