//
//  APICharacterListDataSource.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation
import Combine

@available(iOS 13.0, *)
public class CharacterAPIListDataSource: CharacterAPIListDataSourceType {
    private let httpClient: HttpClient
    
    public init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    public func GetCharactersList() -> AnyPublisher<CharactersDTO.ResponseDTO, HttpClientError> {
        let endpoint = Endpoint(path: "character",
                                queryParameters: ["":""],
                                method: .get)
        return httpClient.makeRequest(endpoint: endpoint, baseUrl: Bundle.main.infoDictionary?["BaseUrl"] as? String ?? "")
    }
}
