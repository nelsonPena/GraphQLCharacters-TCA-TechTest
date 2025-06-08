//
//  AppCoordinator.swift
//  TCATechnicalTest
//
//  Created by Nelson Peña Agudelo on 7/06/25.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct AppCoordinator {
    @ObservableState
    enum State {
        case splash(SplashDomain.State)
        case main(CharacterListDomain.State) // Por ejemplo

        var isSplashFinished: Bool {
            switch self {
            case .splash(let splashState): splashState.isActive
            default: true
            }
        }
    }

    enum Action {
        case splash(SplashDomain.Action)
        case main(CharacterListDomain.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.splash, action: \.splash) {
            SplashDomain()
        }

        Scope(state: \.main, action: \.main) {
            CharacterListDomain()
        }

        Reduce { state, action in
            switch action {
            case .splash(.timerFinished):
                state = .main(CharacterListDomain.State())
                return .none
            case .splash, .main:
                return .none
            }
        }
    }
}
