//
//  File.swift
//  Presentation
//
//  Created by Nelson Peña Agudelo on 8/06/25.
//

import Foundation

public final class CharacterListState: ObservableObject {
    @Published public var selectedCharacter: CharacterDetailViewData?

    public init() {}
}
