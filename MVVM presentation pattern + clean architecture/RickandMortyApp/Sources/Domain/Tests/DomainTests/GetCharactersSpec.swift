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
@testable import UseCases
import Foundation

final class GetCharactersSpec: QuickSpec {
    override func spec() {
        var getCharacters: GetCharacters!
        var repository: MockCharactersRepositoryType!
        
        describe("GetCharacters") {
            beforeEach {
                repository = MockCharactersRepositoryType()
                getCharacters = GetCharacters(repository: repository)
            }
            
            context("when repository returns characters") {
                it("returns character response") {
                    let expectedResponse = Characters.Response(results: [])
                    repository.getCharactersResult = .success(expectedResponse)
                    
                    var result: Characters.Response?
                    _ = getCharacters.getCharacters()
                        .sink(receiveCompletion: { _ in }, receiveValue: { response in
                            result = response
                        })
                    
                    await expect(result).toEventually(equal(expectedResponse))
                }
            }
            
            context("when repository is nil or fails") {
                it("returns DomainError.generic") {
                    getCharacters = GetCharacters(repository: nil)
                    
                    var receivedError: DomainError?
                    _ = getCharacters.getCharacters()
                        .sink(receiveCompletion: { completion in
                            if case let .failure(error) = completion {
                                receivedError = error
                            }
                        }, receiveValue: { _ in })
                    
                    await expect(receivedError).toEventually(equal(DomainError.generic))
                }
            }
        }
    }
}
