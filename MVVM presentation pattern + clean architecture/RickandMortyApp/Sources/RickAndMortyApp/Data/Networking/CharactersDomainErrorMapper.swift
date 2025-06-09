//
//  CharactersDomainErrorMapper.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation

extension URLError{
    func map() -> DomainError {
        switch self.code {
        case .badURL,
                .badServerResponse:
            return .generic
        case .timedOut:
            return .timeOut
        default:
            return .generic
        }
    }
}
