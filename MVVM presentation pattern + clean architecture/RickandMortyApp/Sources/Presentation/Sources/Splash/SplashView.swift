//
//  SplashView.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import SwiftUI

public struct SplashView: View {
    @ObservedObject var state: SplashState
    
    public init(state: SplashState) {
        self.state = state
    }

    public var body: some View {
         ZStack {
             Color.purple.ignoresSafeArea()
             Image("icons-rick-sanchez")
         }
         .onAppear {
             DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                 withAnimation {
                     state.didFinishSplash = true
                 }
             }
         }
     }
}
