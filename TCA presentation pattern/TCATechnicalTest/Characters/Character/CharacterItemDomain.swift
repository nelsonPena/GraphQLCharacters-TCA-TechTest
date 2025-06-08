//
//  CharacterItemDomain.swift
//  TCA Technical Test
//
//  Created by Nelson Peña Agudelo on 6/06/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CharacterItemDomain {
    @ObservableState
    struct State: Equatable, Identifiable {
        var id: UUID
        var character: Character
    }

    enum Action: Equatable {
        case didTap
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTap:
                return .none
            }
        }
    }
}
