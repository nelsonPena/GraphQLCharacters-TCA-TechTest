//
//  CharactersRepositoryTests.swift
//  RickAndMortyAppTests
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import XCTest
import Combine
@testable import RickAndMortyApp

final class CharactersRepositoryTests: XCTestCase {
    
    // MARK: - Properties
    private var cancellables: Set<AnyCancellable>!
    private var mockHttpClient: MockURLSessionHTTPClient!
    private var repository: CharacterListRepository!
    private var dataSource: APICharacterListDataSource!

    // MARK: - Setup & TearDown
    override func setUp() {
        super.setUp()
        cancellables = []
        mockHttpClient = MockURLSessionHTTPClient()
        dataSource = APICharacterListDataSource(httpClient: mockHttpClient)
        repository = CharacterListRepository(apiDataSource: dataSource)
    }

    override func tearDown() {
        cancellables = nil
        mockHttpClient = nil
        repository = nil
        dataSource = nil
        super.tearDown()
    }

    // MARK: - Test Cases

    /// Prueba que `getCharacters` obtiene correctamente los personajes desde el JSON local.
    func testGetCharactersSuccess() async {
        // Act
        let expectation = expectation(description: "Se obtienen y mapean los personajes correctamente")
        repository.getCharacters()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Se esperaba una respuesta exitosa, pero se recibió un error")
                }
            }, receiveValue: { characters in
                // Assert
                XCTAssertGreaterThan(characters.results.count, 0, "No se obtuvieron personajes del JSON")
                XCTAssertEqual(characters.results.first?.name, "Rick Sanchez", "El nombre del personaje no es el esperado")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        await fulfillment(of: [expectation], timeout: 1)
    }
}
