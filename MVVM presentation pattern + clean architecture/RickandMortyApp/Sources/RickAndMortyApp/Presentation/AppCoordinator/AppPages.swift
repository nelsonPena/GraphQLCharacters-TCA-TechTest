//
//  AppPages.swift
//  RickAndMortyApp
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation

enum AppPages: Hashable {
    case splash
    case main
    case detail(viewData: CharacterDetailViewData)
    
    static func == (lhs: AppPages, rhs: AppPages) -> Bool {
          switch (lhs, rhs) {
          case (.splash, .splash):
              return true
          case (.main, .main):
              return true
          case let (.detail(lhsData), .detail(rhsData)):
              return lhsData.id == rhsData.id // Comparar solo por ID u otra propiedad única
          default:
              return false
          }
      }

      func hash(into hasher: inout Hasher) {
          switch self {
          case .splash:
              hasher.combine("splash")
          case .main:
              hasher.combine("main")
          case let .detail(viewData):
              hasher.combine(viewData.id) // Usar una propiedad que sea Hashable
          }
      }
}
