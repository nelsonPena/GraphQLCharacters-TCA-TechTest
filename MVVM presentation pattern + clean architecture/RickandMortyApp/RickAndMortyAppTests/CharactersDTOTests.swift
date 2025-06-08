//
//  CharactersDTOTests.swift
//  RickAndMortyAppTests
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import XCTest
@testable import RickAndMortyApp

final class CharactersDTOTests: XCTestCase {

    /// Prueba que `CharactersDTO.ResultDTO.mapper()` convierte correctamente los datos de la API al modelo de dominio.
    func testMapper_ConvertsDTOToDomainModel() {
        // Arrange
        let dto = CharactersDTO.ResultDTO(
            id: 1,
            name: "Rick Sanchez",
            status: .alive,
            species: .human,
            type: "",
            gender: .male,
            origin: CharactersDTO.LocationDTO(name: "Earth (C-137)", url: ""),
            location: CharactersDTO.LocationDTO(name: "Citadel of Ricks", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            url: "",
            created: "2017-11-04T18:48:46.250Z"
        )

        // Act
        let domainModel = dto.mapper()

        // Assert
        XCTAssertEqual(domainModel.id, 1)
        XCTAssertEqual(domainModel.name, "Rick Sanchez")
        XCTAssertEqual(domainModel.status, .alive)
        XCTAssertEqual(domainModel.species, .human)
        XCTAssertEqual(domainModel.origin.name, "Earth (C-137)")
    }
}
