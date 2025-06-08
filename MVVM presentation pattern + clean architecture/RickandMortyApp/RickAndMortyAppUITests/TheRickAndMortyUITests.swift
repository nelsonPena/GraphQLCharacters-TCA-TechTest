//
//  RickAndMortyAppUITests.swift
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import XCTest

final class RickAndMortyAppUITests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    // MARK: - Test Cases
    
    /// Prueba la navegación desde la lista de los personajes  a la vista de detalle.
    func testCharacterListNavigation() {
        let app = XCUIApplication()
        _ = app.tables.element.waitForExistence(timeout: 1)
        app.cells.element(boundBy: 3).tap()
        XCTAssertTrue(app.staticTexts["Detalle"].exists)
    }
    
    /// Prueba seleccionar un personaje desde la vista de detalle.
    func testSelctCharacter() {
        let app = XCUIApplication()
        _ = app.tables.element.waitForExistence(timeout: 1)
        app.cells.element(boundBy: 3).tap()
        
        // Obtiene el valor de la etiqueta en la vista de detalle
        let miValorLabel = app.staticTexts.matching(identifier: "nameLabel").firstMatch
        let valor = miValorLabel.label
        
        // Toca el botón de eliminar
        let doneButton = app.buttons.matching(identifier: "doneButton").firstMatch
        doneButton.tap()
        
        // Verifica que la celda con el mismo valor ya no exista
        let cell = app.tables.cells.containing(.staticText, identifier: valor).element
        XCTAssertFalse(cell.exists)
    }
}
