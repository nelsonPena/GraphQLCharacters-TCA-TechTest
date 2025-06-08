//
//  CharacterListViewModel.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import UIKit
import Combine

/// ViewModel responsable de gestionar la lógica y los datos de la vista de lista de personajes.
class CharactersViewModel: ObservableObject {
    
    // MARK: - Properties
    
    /// Caso de uso para la obtención de personajes.
    private let getCharactersListUseCase: GetCharactersListType
    
    /// Mapeador de errores para presentar mensajes específicos.
    private let errorMapper: CharactersPresentableErrorMapper
    
    /// Proveedor de datos para manejar personajes persistidos.
    private var dataProvider: DataProvider?
    
    /// Suscripciones activas en el ViewModel.
    private var cancellables = Set<AnyCancellable>()
    
    /// Lista de personajes guardados en caché.
    @Published var savedCharacters: [SavedCharacters] = []
    
    /// Lista de personajes para mostrar en la vista.
    @Published var characters: [CharacterListPresentableItem] = []
    
    /// Indicador para mostrar un spinner de carga.
    @Published var showLoadingSpinner: Bool = false
    
    /// Mensaje de error para mostrar en caso de fallos.
    @Published var showErrorMessage: String?
    
    /// Mensaje personalizado para el indicador de carga.
    @Published var loaderMessage: String = ""
    
    // MARK: - Initializer
    
    /// Inicializa el ViewModel con las dependencias necesarias.
    /// - Parameters:
    ///   - getCharactersListUseCase: Caso de uso para obtener personajes.
    ///   - dataProvider: Proveedor de datos para manejo de personajes persistidos.
    ///   - errorMapper: Mapeador de errores específicos para la vista.
    init(getCharactersListUseCase: GetCharactersListType,
         dataProvider: DataProvider,
         errorMapper: CharactersPresentableErrorMapper) {
        self.getCharactersListUseCase = getCharactersListUseCase
        self.dataProvider = dataProvider
        self.errorMapper = errorMapper
        setup()
    }
    
    // MARK: - Public Methods
    
    /// Retorna el proveedor de datos asociado.
    /// - Returns: Instancia de `DataProvider`.
    func getDataProvider() -> DataProvider? {
        guard let dataProvider else { return nil }
        return dataProvider
    }
    
    /// Configura el ViewModel cargando los datos necesarios.
    func setup() {
        showLoadingSpinner = true
        showErrorMessage = nil
        loaderMessage = "loading_records".localized
        loadCharactersFromCache()
    }
    
    // MARK: - Private Methods
    
    /// Carga los personajes desde la caché y actualiza las propiedades publicadas.
    private func loadCharactersFromCache() {
        guard let dataProvider else { return }
        dataProvider.$characters
            .sink { [weak self] characters in
                self?.savedCharacters = characters
                if characters.isEmpty {
                    self?.fetchCharactersFromServer()
                } else {
                    self?.characters = characters.map { $0.mapper() }
                    self?.showLoadingSpinner = false
                }
            }
            .store(in: &cancellables)
    }

    
    /// Obtiene los personajes desde el servidor y los guarda en caché.
    private func fetchCharactersFromServer() {
        getCharactersListUseCase.getCharacters()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.handleError(error: error)
                }
            }, receiveValue: { [weak self] characters in
                guard let self = self, let dataProvider = self.dataProvider else { return }
                let charactersPresentable = characters.results.map { CharacterListPresentableItem(domainModel: $0) }
                self.characters = charactersPresentable
                dataProvider.add(characters: charactersPresentable)
                self.showLoadingSpinner = false
            })
            .store(in: &cancellables)
    }
    
    /// Maneja los errores ocurridos durante las operaciones.
    /// - Parameter error: Instancia opcional de `DomainError`.
    private func handleError(error: DomainError?) {
        showLoadingSpinner = false
        showErrorMessage = errorMapper.map(error: error)
    }
}
