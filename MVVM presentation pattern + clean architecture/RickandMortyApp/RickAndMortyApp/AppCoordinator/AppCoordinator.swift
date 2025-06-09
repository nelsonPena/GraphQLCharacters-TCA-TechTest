//
//  AppCoordinator.swift
//  RickAndMortyApp
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import SwiftUI
import Combine
import Characters
import Splash

final class AppCoordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    @Published var splashState = SplashState()
    @Published var characterListState = CharacterListState()
    @Published var characterDetailState = CharacterDetailState()

    init() {
        $splashState
            .flatMap(\.$didFinishSplash)
            .filter { $0 } // solo cuando sea true
            .sink { [weak self] _ in
                self?.replaceStack(with: .main)
            }
            .store(in: &cancellables)
        
        characterListState.$selectedCharacter
            .compactMap { $0 }
            .sink { [weak self] viewData in
                self?.push(page: .detail(viewData: viewData))
            }
            .store(in: &cancellables)
        
        characterDetailState.$didTapDone
            .filter { $0 }
            .sink { [weak self] _ in
                self?.pop()
                self?.characterDetailState.didTapDone = false // Reiniciar para futuras navegaciones
            }
            .store(in: &cancellables)
    }

    private var cancellables = Set<AnyCancellable>()

    func push(page: AppPages) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func replaceStack(with page: AppPages) {
        path = NavigationPath()
        path.append(page)
    }

    func build(page: AppPages) -> AnyView {
        switch page {
        case .splash:
            return AnyView(SplashView(state: splashState))
        case .main:
            return AnyView(CharacterListFactory().build(characterListState: characterListState))
        case .detail(let viewData):
            return AnyView(CharacterDetailFactory().build(with: viewData, state: characterDetailState))
        }
    }
}
