//
//  CharacterListFactory.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation

/// `CharacterListFactory` es una factoría que encapsula la lógica para crear las instancias necesarias para la vista de lista de personajes (`CharacterListView`) y su modelo de vista (`CharacterListViewModel`).
///
/// Este patrón de diseño ayuda a mantener el código modular y escalable, delegando la creación de dependencias a un único punto centralizado.
class CharacterListFactory {

    // MARK: - Properties

    private let httpClient: HttpClient

    // MARK: - Initialization

    /// Inicializa una nueva instancia de `CharacterListFactory` con un cliente HTTP opcional.
    ///
    /// - Parameters:
    ///   - httpClient: Un cliente HTTP para realizar solicitudes de red. Por defecto, se utiliza una implementación basada en `URLSession`.
    init(httpClient: HttpClient = URLSessionHTTPCLient(requestMaker: UrlSessionRequestMaker(),
                                                       errorResolver: URLSessionErrorResolver())) {
        self.httpClient = httpClient
    }

    // MARK: - Public Methods

    /// Construye y devuelve una instancia de `CharacterListView` junto con su modelo de vista.
    ///
    /// - Returns: Una instancia de `CharacterListView`.
    func build() -> CharacterListView {
        CharacterListView(viewModel: createViewModel())
    }

    // MARK: - ViewModel Factory

    /// Construye y devuelve una instancia de `CharactersViewModel` con sus dependencias configuradas.
    ///
    /// - Returns: Una instancia de `CharactersViewModel`.
    private func createViewModel() -> CharactersViewModel {
        CharactersViewModel(
            getCharactersListUseCase: createUseCase(),
            dataProvider: createDataProviderUseCase(),
            errorMapper: CharactersPresentableErrorMapper()
        )
    }

    /// Construye y devuelve un caso de uso (`GetCharactersListType`) para gestionar la lógica de obtención de personajes.
    ///
    /// - Returns: Una instancia de `GetCharactersListType`.
    private func createUseCase() -> GetCharactersListType {
        GetCharacters(repository: createRepository())
    }

    /// Construye y devuelve un repositorio (`CharactersRepositoryType`) que gestiona el acceso a datos desde el API.
    ///
    /// - Returns: Una instancia de `CharactersRepositoryType`.
    private func createRepository() -> CharactersRepositoryType {
        CharacterListRepository(apiDataSource: createDataSource())
    }

    /// Construye y devuelve una fuente de datos (`ApiCharacterListDataSourceType`) para interactuar con el API.
    ///
    /// - Returns: Una instancia de `ApiCharacterListDataSourceType`.
    private func createDataSource() -> ApiCharacterListDataSourceType {
        APICharacterListDataSource(httpClient: httpClient)
    }
}

// MARK: - CoreData Factory

extension CharacterListFactory {

    // MARK: - Public Methods

    /// Construye y devuelve una instancia de `DataProvider` configurada con un repositorio de datos persistentes.
    ///
    /// - Returns: Una instancia de `DataProvider`.
    func createDataProviderUseCase() -> DataProvider {
        DataProvider(model: createDataLayerRepository())
    }

    // MARK: - Private Methods

    /// Construye y devuelve un repositorio de capa de datos (`DataLayerRepository`) para gestionar datos persistentes.
    ///
    /// - Returns: Una instancia de `DataLayerRepository`.
    private func createDataLayerRepository() -> DataLayerRepository {
        DataLayerRepository(provider: createPersistence())
    }

    /// Construye y devuelve una pila de persistencia (`CoreDataStack`) configurada con el contexto compartido.
    ///
    /// - Returns: Una instancia de `CoreDataStack`.
    private func createPersistence() -> CoreDataStack {
        CoreDataStack(context: PersistenceController.shared.container.viewContext)
    }
}
