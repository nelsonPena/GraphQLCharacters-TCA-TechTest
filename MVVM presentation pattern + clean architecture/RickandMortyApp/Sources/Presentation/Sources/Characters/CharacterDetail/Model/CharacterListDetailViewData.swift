//
//  CharacterListDetailViewData.swift
//  TheRickAndMorty
//
//  Created by Nelson Geovanny Pena Agudelo on 16/10/23.
//

import Foundation
import SwiftUI

public struct CharacterDetailViewData: Hashable, Identifiable {
    public let id: UUID
    public let detail: CharacterDetailPresentableItem

    public init(detail: CharacterDetailPresentableItem) {
        self.id = UUID()
        self.detail = detail
    }

    public static func == (lhs: CharacterDetailViewData, rhs: CharacterDetailViewData) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

