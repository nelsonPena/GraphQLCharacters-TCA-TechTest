//
//  HttpCLient.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation
import Combine

protocol HttpClient {
    func makeRequest<T: Decodable>(endpoint: Endpoint, baseUrl: String) -> AnyPublisher<T, HttpClientError>
}
