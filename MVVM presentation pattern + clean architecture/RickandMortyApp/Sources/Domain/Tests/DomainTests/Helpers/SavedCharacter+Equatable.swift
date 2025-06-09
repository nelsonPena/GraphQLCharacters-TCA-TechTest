//
//  File.swift
//  Domain
//
//  Created by Nelson Peña Agudelo on 8/06/25.
//

import Entities

extension SavedCharacter: Equatable {
    public static func == (lhs: SavedCharacter, rhs: SavedCharacter) -> Bool {
        return lhs.id == rhs.id // o cualquier combinación que defina igualdad
    }
}
