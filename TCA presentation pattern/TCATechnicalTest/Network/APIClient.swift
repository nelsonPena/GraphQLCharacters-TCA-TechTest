//
//  APIClient.swift
//  TCATechnicalTest
//
//  Created by Nelson Peña Agudelo on 6/06/25.
//

import Foundation
import ComposableArchitecture
import DependenciesMacros

extension DependencyValues {
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}

@DependencyClient
struct APIClient {
    var fetchCharactersPaginated: @Sendable (_ page: Int) async throws -> [Character]
    
    struct Failure: Error, Equatable {}
}

extension APIClient: TestDependencyKey {
    static let testValue = Self(
        fetchCharactersPaginated: { _ in [] }
    )
}

// This is the "live" fact dependency that reaches into the outside world to fetch the data from network.
// Typically this live implementation of the dependency would live in its own module so that the
// main feature doesn't need to compile it.
extension APIClient: DependencyKey {
    static let liveValue = Self(
        fetchCharactersPaginated: { page in
            let query = """
              query {
                characters(page: \(page)) {
                  results {
                    id
                    name
                    status
                    species
                    gender
                    origin {
                      name
                    }
                    location {
                      name
                    }
                    image
                    created
                  }
                }
              }
              """
            
            var request = URLRequest(url: URL(string: "https://rickandmortyapi.com/graphql")!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let requestBody: [String: Any] = ["query": query]
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
            
            let (data, _) = try await URLSession.shared.data(for: request)
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
               let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
               let jsonString = String(data: prettyData, encoding: .utf8) {
                print("🔽 JSON Response:\n\(jsonString)")
            }
            let response = try JSONDecoder().decode(GraphQLCharactersResponse.self, from: data)
            return response.data.characters.results
        }
    )
}
