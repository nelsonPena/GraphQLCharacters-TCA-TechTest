//
//  Gender.swift
//  TCATechnicalTest
//
//  Created by Nelson Peña Agudelo on 6/06/25.
//

import Foundation

enum Gender: String, Codable {
    case male = "Male"
    case female = "Female"
    case unknown = "unknown"
    case genderless = "Genderless"
}

extension Gender {
    func map() -> String {
        switch self {
        case .female:
            "text_female_gender".localized
        case .male:
            "text_male_gender".localized
        case .unknown:
            "text_unknown_gender".localized
        case .genderless:
            "text_genderless_gender".localized
        }
    }
}
