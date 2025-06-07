//
//  Species.swift
//  TCATechnicalTest
//
//  Created by Nelson Peña Agudelo on 6/06/25.
//

import Foundation

enum Species: Equatable {
    case human
    case alien
    case humanoid
    case poopybutthole
    case mythologicalCreature
    case unknown(String)
}

extension Species: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self).lowercased()

        switch rawValue {
        case "human":
            self = .human
        case "alien":
            self = .alien
        case "humanoid":
            self = .humanoid
        case "poopybutthole":
            self = .poopybutthole
        case "mythological creature":
            self = .mythologicalCreature
        default:
            self = .unknown(rawValue)
        }
    }
}

extension Species {
    func map() -> String {
        switch self {
        case .human:
            return "text_human_species".localized
        case .alien:
            return "text_alien_species".localized
        case .humanoid:
            return "text_humanoid_species".localized
        case .poopybutthole:
            return "text_poopybutthole_species".localized
        case .mythologicalCreature:
            return "text_mythological_creature_species".localized
        case .unknown(let raw):
            return raw.capitalized
        }
    }
}
