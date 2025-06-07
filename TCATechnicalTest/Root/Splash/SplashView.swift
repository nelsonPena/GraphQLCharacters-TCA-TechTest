//
//  SplashView.swift
//  TCATechnicalTest
//
//  Created by Nelson Peña Agudelo on 7/06/25.
//

import SwiftUI
import ComposableArchitecture

struct SplashView: View {
    let store: StoreOf<SplashDomain>

    var body: some View {
        WithPerceptionTracking {
            ZStack {
                Color.white.ignoresSafeArea()
                Color(Color.accentColor)
                    .ignoresSafeArea()
                Image("icons-rick-sanchez")
            }
            .onAppear {
                store.send(.onAppear)
            }
        }
    }
}

#Preview {
    SplashView(
        store: Store(
            initialState: SplashDomain.State(),
            reducer: { SplashDomain() }
        )
    )
}
