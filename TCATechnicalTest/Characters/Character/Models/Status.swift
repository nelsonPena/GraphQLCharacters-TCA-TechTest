//
//  Status.swift
//  TCATechnicalTest
//
//  Created by Nelson Peña Agudelo on 6/06/25.
//

import Foundation

enum Status: String, Codable{
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

extension Status {
    func map() -> String {
        switch self {
        case .alive:
            "text_alive_status".localized
        case .dead:
            "text_dead_status".localized
        case .unknown:
            "text_unknown_status".localized
        }
    }
}
