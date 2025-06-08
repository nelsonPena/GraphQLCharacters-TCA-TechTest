//
//  SplashDomain.swift
//  TCATechnicalTest
//
//  Created by Nelson Peña Agudelo on 7/06/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SplashDomain {
    @ObservableState
    struct State: Equatable {
        var isActive = false
    }

    enum Action: Equatable {
        case onAppear
        case timerFinished
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    try await Task.sleep(nanoseconds: 1_000_000_000) // 2 segundos
                    await send(.timerFinished)
                }

            case .timerFinished:
                state.isActive = true
                return .none
            }
        }
    }
}
