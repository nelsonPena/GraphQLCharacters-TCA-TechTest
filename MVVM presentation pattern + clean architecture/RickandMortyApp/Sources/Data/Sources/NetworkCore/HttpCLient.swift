//
//  HttpCLient.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation
import Combine

@available(iOS 13.0, *)
public protocol HttpClient {
    func makeRequest<T: Decodable>(endpoint: Endpoint, baseUrl: String) -> AnyPublisher<T, HttpClientError>
}
