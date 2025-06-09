//
//  CharacterDetailViewModel.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation
import Combine
import CoreData
import UseCaseProtocol

/// `CharacterDetailViewModel` es un ViewModel observable que maneja la lógica relacionada con la gestión de la interfaz de usuario para la vista de detalles de los personajes .

public class CharacterDetailViewModel: ObservableObject, Hashable, Identifiable {
    
    /// Una propiedad publicada que indica si se debe mostrar un indicador de carga.
    @Published var showLoadingSpinner: Bool = false
    
    
    public let id = UUID()
    private let getCharactersListType: GetCharactersListType
    private let errorMapper: CharactersPresentableErrorMapper
    
    /// El objeto `CharacterListPresentableItem` que representa los detalles de el personaje
    let characterDetailPresentable: CharacterDetailPresentableItem
    
    private var cancellables = Set<AnyCancellable>()
    
    /// Inicializa una nueva instancia de `CharacterDetailViewModel`.
    ///
    /// - Parameters:
    ///   - GetCharactersListType: Un objeto que implementa `GetCharactersListType` .
    ///   - dataProvider: Un objeto `DataProvider` que gestiona las los personajes en cache.
    ///   - CharacterDetailPresentable: El objeto `CharacterListPresentableItem` que representa los detalles de el personaje.
    ///   - errorMapper: Un mapeador que se utiliza para transformar errores en mensajes de error legibles.
    public init(getCharactersListType: GetCharactersListType,
         characterDetailPresentable: CharacterDetailPresentableItem,
         errorMapper: CharactersPresentableErrorMapper) {
        self.getCharactersListType = getCharactersListType
        self.characterDetailPresentable = characterDetailPresentable
        self.errorMapper = errorMapper
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    public static func == (lhs: CharacterDetailViewModel, rhs: CharacterDetailViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
