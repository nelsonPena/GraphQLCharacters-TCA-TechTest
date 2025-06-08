//
//  CharacterListErrorMapper.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation

class CharactersPresentableErrorMapper {
    func map(error: DomainError?) -> String {
        guard error == .generic else {
            return "generic_text_error".localized
        }
        return "try_later_text_error".localized
    }
}
