//
//  Endpoint.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation

public struct Endpoint {
   public let path: String
   public let queryParameters: [String: Any]
   public let method: HTTPMethod
}

