//
//  GetCharactersTests.swift
//  RickAndMortyAppTests
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import XCTest
import Combine
@testable import RickAndMortyApp

final class GetCharactersTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    private var mockRepository: MockCharactersRepository!
    private var getCharactersUseCase: GetCharacters!

    override func setUp() {
        super.setUp()
        cancellables = []
        mockRepository = MockCharactersRepository()
        getCharactersUseCase = GetCharacters(repository: mockRepository)
    }

    override func tearDown() {
        cancellables = nil
        mockRepository = nil
        getCharactersUseCase = nil
        super.tearDown()
    }

    func testGetCharactersSuccess() {
        // Configurar el repositorio simulado para devolver una respuesta exitosa
        let expectedCharacters = Characters.Response(
            results: [Characters.Result(
                id: 1,
                name: "Rick Sanchez",
                status: .alive,
                species: .human,
                type: "",
                gender: .male,
                origin: .init(name: "Earth", url: ""),
                location: .init(name: "Earth", url: ""),
                image: "",
                url: "",
                created: ""
            )]
        )
        mockRepository.result = .success(expectedCharacters)

        let expectation = self.expectation(description: "Se obtienen los personajes correctamente")

        getCharactersUseCase.getCharacters()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Se esperaba una respuesta exitosa, pero se recibió un error")
                }
            }, receiveValue: { characters in
                XCTAssertEqual(characters, expectedCharacters, "Los personajes obtenidos no coinciden con los esperados")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetCharactersFailure() {
        // Configurar el repositorio simulado para devolver un error
        mockRepository.result = .failure(.generic)

        let expectation = self.expectation(description: "Se maneja correctamente el error al obtener los personajes")

        getCharactersUseCase.getCharacters()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .generic, "El error recibido no coincide con el esperado")
                    expectation.fulfill()
                } else {
                    XCTFail("Se esperaba un error, pero se recibió una respuesta exitosa")
                }
            }, receiveValue: { _ in
                XCTFail("Se esperaba un error, pero se recibieron personajes")
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1, handler: nil)
    }
}

// Mock del repositorio de personajes
final class MockCharactersRepository: CharactersRepositoryType {
    var result: Result<Characters.Response, DomainError>?

    func getCharacters() -> AnyPublisher<Characters.Response, DomainError> {
        if let result = result {
            return result.publisher.eraseToAnyPublisher()
        } else {
            return Fail(error: .generic).eraseToAnyPublisher()
        }
    }
}
