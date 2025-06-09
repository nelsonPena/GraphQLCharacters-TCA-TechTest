//
//  File.swift
//  Presentation
//
//  Created by Nelson Peña Agudelo on 8/06/25.
//

import Combine

public final class CharacterDetailState: ObservableObject {
    @Published public var didTapDone: Bool = false

    public init() {}
}
