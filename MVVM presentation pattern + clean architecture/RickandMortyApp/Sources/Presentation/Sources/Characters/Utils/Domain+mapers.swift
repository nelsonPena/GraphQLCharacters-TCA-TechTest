//
//  Domain+mapers.swift
//  Presentation
//
//  Created by Nelson Peña Agudelo on 8/06/25.
//
import Entities

public extension Characters.Gender {
    func map(gender: Characters.Gender) -> String {
        switch gender {
        case .female:
            "text_female_gender".localized
        case .male:
            "text_male_gender".localized
        case .unknown:
            "text_unknown_gender".localized
        }
    }
}

public extension Characters.Species {
    func map(species: Characters.Species) -> String {
        switch species {
        case .alien:
            "text_alien_species".localized
        case .human:
            "text_human_species".localized
        }
    }
}

extension Characters.Status {
    func map(status: Characters.Status) -> String {
        switch status {
        case .alive:
            "text_alive_status".localized
        case .dead:
            "text_dead_status".localized
        case .unknown:
            "text_unknown_status".localized
        }
    }
}
