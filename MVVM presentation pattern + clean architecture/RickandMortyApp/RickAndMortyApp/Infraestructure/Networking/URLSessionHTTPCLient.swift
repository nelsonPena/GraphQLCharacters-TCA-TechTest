//
//  URLSessionHTTPCLient.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation
import Combine

/// `URLSessionHTTPCLient` es una implementación de un cliente HTTP que utiliza la API URLSession de Foundation y Combine para realizar solicitudes HTTP.

class URLSessionHTTPCLient: HttpClient {
    
    private let session: URLSession
    private let requestMaker: UrlSessionRequestMaker
    private let errorResolver: URLSessionErrorResolver
    
    init(session: URLSession = .shared,
         requestMaker: UrlSessionRequestMaker,
         errorResolver: URLSessionErrorResolver) {
        self.session = session
        self.requestMaker = requestMaker
        self.errorResolver = errorResolver
    }
    
    func makeRequest<T: Decodable>(endpoint: Endpoint, baseUrl: String) -> AnyPublisher<T, HttpClientError> {
        guard let url = self.requestMaker.url(endpoint: endpoint, baseUrl: baseUrl) else {
            print("❌ Error: URL inválida generada por requestMaker para endpoint: \(endpoint)")
            return Fail(error: .badURL).eraseToAnyPublisher()
        }

        print("🔁 Iniciando solicitud GET a URL: \(url)")
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result in
                guard let response = result.response as? HTTPURLResponse else {
                    print("❌ Error: No se pudo obtener una respuesta HTTPURLResponse válida.")
                    throw HttpClientError.badURL
                }
                guard response.statusCode == 200 else {
                    print("❌ Error HTTP: Código de estado = \(response.statusCode)")
                    throw self.errorResolver.resolve(statusCode: response.statusCode)
                }
                print("✅ Respuesta HTTP 200 OK recibida.")
                return result.data
            }
            .mapError { error in
                if let urLError = error as? URLError {
                    if urLError.code == .timedOut {
                        print("❌ Error: Tiempo de espera agotado.")
                        return HttpClientError.timeOut
                    } else {
                        print("❌ URLError: \(urLError.localizedDescription)")
                    }
                } else {
                    print("❌ Error desconocido: \(error.localizedDescription)")
                }
                return (error as? HttpClientError) ?? .generic
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                print("❌ Error al decodificar el JSON: \(error.localizedDescription)")
                return .generic
            }
            .eraseToAnyPublisher()
    }

    func makeDelete(endpoint: Endpoint, baseUrl: String) -> AnyPublisher<HTTPURLResponse, HttpClientError> {
        guard let url = self.requestMaker.urlRequest(endpoint: endpoint, baseUrl: baseUrl) else {
            print("❌ Error: URLRequest inválido generado para endpoint DELETE: \(endpoint)")
            return Fail(error: .badURL).eraseToAnyPublisher()
        }

        print("🗑️ Iniciando solicitud DELETE a URL: \(url)")
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .compactMap { result in
                if let response = result.response as? HTTPURLResponse {
                    print("✅ DELETE completado con código de estado: \(response.statusCode)")
                    return response
                } else {
                    print("❌ DELETE fallido: no se obtuvo HTTPURLResponse")
                    return nil
                }
            }
            .mapError { error in
                if error.code == .timedOut {
                    print("❌ DELETE falló por timeout.")
                    return .timeOut
                } else {
                    print("❌ DELETE error: \(error.localizedDescription)")
                    return .generic
                }
            }
            .eraseToAnyPublisher()
    }
}
