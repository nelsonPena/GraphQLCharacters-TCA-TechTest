//
//  TheRickAndMortyApp.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    @StateObject private var coordinator = AppCoordinator()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.purple]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.purple]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                coordinator.build(page: .splash)
                    .navigationDestination(for: AppPages.self) { page in
                        coordinator.build(page: page)
                    }
            }
        }
    }
}
