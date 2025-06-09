//
//  String+Extensions.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation

public extension String {
    var localized: String {
        NSLocalizedString(self, bundle: .main, comment: "")
    }
}
