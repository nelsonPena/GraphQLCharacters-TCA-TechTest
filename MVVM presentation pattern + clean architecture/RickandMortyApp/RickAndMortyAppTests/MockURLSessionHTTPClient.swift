//
//  MockURLSessionHTTPClient.swift
//  RickAndMortyAppTests
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation
import Combine
@testable import RickAndMortyApp

/// `MockURLSessionHTTPClient` simula peticiones HTTP utilizando un archivo JSON local.
class MockURLSessionHTTPClient: HttpClient {
    
    /// Simula una petición HTTP utilizando datos de un archivo JSON.
    func makeRequest<T: Decodable>(endpoint: Endpoint, baseUrl: String) -> AnyPublisher<T, HttpClientError> {
        
        // Cargar datos desde el archivo JSON de pruebas
        guard let mockData = MockData().loadMockData(fromJSONFile: "mock_characters", objectType: T.self) else {
            return Fail(error: .generic).eraseToAnyPublisher()
        }
        
        // Retornar datos como si fueran obtenidos de una API real
        return Just(mockData)
            .setFailureType(to: HttpClientError.self)
            .eraseToAnyPublisher()
    }
}
