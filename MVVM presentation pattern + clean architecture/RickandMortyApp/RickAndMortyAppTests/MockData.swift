//
//  MockData.swift
//  RickAndMortyAppTests
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation

/// `MockData` proporciona una utilidad para cargar datos de prueba desde un archivo JSON local.
class MockData {
    
    /// Carga y decodifica un archivo JSON en un objeto de tipo `T`.
    ///
    /// - Parameters:
    ///   - fileName: Nombre del archivo JSON sin la extensión.
    ///   - objectType: Tipo de objeto `Decodable` esperado.
    /// - Returns: Un objeto decodificado de tipo `T`, o `nil` en caso de error.
    func loadMockData<T: Decodable>(fromJSONFile fileName: String, objectType: T.Type) -> T? {
        guard let url = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json") else {
            fatalError("❌ No se encontró el archivo \(fileName).json en el bundle de pruebas.")
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print("⚠️ Error al cargar \(fileName).json: \(error)")
            return nil
        }
    }
}
