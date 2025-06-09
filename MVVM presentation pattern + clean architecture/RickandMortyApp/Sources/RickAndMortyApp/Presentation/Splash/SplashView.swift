//
//  SplashView.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    @EnvironmentObject private var coordinator: AppCoordinator
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.purple]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.purple]
    }
    
    var body: some View {
        VStack{
            if self.isActive {
                coordinator.build(page: .main)
            } else {
                ZStack{
                    Color(.purple)
                        .ignoresSafeArea()
                    Image("icons-rick-sanchez")
                }
            }
            
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        
    }
}

#Preview {
    SplashView()
}
