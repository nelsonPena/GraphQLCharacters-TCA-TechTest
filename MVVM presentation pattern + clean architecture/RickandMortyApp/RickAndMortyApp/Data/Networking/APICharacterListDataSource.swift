//
//  APICharacterListDataSource.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation
import Combine

class APICharacterListDataSource: ApiCharacterListDataSourceType {
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func GetCharactersList() -> AnyPublisher<CharactersDTO.ResponseDTO, HttpClientError> {
        let endpoint = Endpoint(path: "character",
                                queryParameters: ["":""],
                                method: .get)
        return httpClient.makeRequest(endpoint: endpoint, baseUrl: Bundle.main.infoDictionary?["BaseUrl"] as? String ?? "")
    }
}
