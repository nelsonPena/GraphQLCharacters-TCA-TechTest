//
//  TCATechnicalTestApp.swift
//  TCATechnicalTest
//
//  Created by Nelson Peña Agudelo on 6/06/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCATechnicalTestApp: App {
    
    var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(
                    initialState: AppCoordinator.State.splash(SplashDomain.State()),
                    reducer: { AppCoordinator() }
                )
            )
        }
    }
}
