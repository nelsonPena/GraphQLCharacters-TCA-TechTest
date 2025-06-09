//
//  CharactersListDomainError.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation

public enum DomainError: Error {
    case badServerResponse
    case timeOut
    case generic
}
