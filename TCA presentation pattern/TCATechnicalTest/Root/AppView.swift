//
//  AppView.swift
//  TCATechnicalTest
//
//  Created by Nelson Peña Agudelo on 7/06/25.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    let store: StoreOf<AppCoordinator>

    var body: some View {
        WithPerceptionTracking {
            switch store.state {
            case .splash:
                if let splashStore = store.scope(state: \.splash, action: \.splash) {
                    SplashView(store: splashStore)
                }
            case .main:
                if let mainStore = store.scope(state: \.main, action: \.main) {
                    CharacterListView(store: mainStore)
                }
            }
        }
    }
}
