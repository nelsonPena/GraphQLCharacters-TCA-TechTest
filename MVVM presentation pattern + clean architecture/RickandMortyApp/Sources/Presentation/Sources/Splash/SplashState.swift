//
//  File.swift
//  Presentation
//
//  Created by Nelson Peña Agudelo on 8/06/25.
//

import Foundation

public final class SplashState: ObservableObject {
    
    public init() {}
    
    @Published public var didFinishSplash: Bool = false
}
