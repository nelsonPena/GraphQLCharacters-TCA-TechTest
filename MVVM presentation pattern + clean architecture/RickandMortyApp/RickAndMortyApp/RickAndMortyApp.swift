//
//  TheRickAndMortyApp.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            coordinator.build(page: .splash)
                .environmentObject(coordinator)
                .environmentObject(networkMonitor)
        }
    }
}
