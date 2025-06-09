//
//  AppCoordinator.swift
//  RickAndMortyApp
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import SwiftUI
import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()

    func push(page: AppPages) {
        path.append(page)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    @ViewBuilder
    func build(page: AppPages) -> some View {
        switch page {
        case .splash: SplashView()
        case .main: CharacterListFactory().build()
        case .detail(let viewData): CharacterDetailFactory().build(with: viewData)
        }
    }
}
