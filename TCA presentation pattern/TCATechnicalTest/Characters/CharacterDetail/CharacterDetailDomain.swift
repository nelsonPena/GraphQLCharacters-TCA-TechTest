//
//  CharacterDetailDomain.swift
//  TCATechnicalTest
//
//  Created by Nelson Peña Agudelo on 6/06/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CharacterDetailDomain {
    
    @ObservableState
    struct State: Equatable {
        var character: CharacterDetail?
    }
    
    enum Action: Equatable {
        case didPressCloseButton
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didPressCloseButton:
                return .none
            }
        }
    }
}
