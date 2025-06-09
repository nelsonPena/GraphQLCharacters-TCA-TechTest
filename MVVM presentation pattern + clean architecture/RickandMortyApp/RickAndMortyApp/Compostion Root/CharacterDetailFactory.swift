//
//  CharacterDetailFactory.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation
import SwiftUI
import UseCaseProtocol
import UseCases
import RepositoryProtocol
import NetworkCore
import Repositories
import Networking
import Characters

/// `CharacterDetailFactory` es una factoría que encapsula la lógica para crear instancias de la vista de detalles de los personajes (`CharacterDetailView`) y su modelo de vista (`CharacterDetailViewModel`).
///
/// Este patrón de diseño ayuda a mantener la arquitectura modular y facilita la inyección de dependencias.
class CharacterDetailFactory {

    // MARK: - Public Methods

    /// Construye y devuelve una instancia de `CharacterDetailView` con su `ViewModel` configurado.
    ///
    /// - Parameters:
    ///   - viewData: Los datos de vista que se utilizarán para configurar la vista y su modelo de detalles.
    /// - Returns: Una instancia de `CharacterDetailView`.
    func build(with viewData: CharacterDetailViewData, state: CharacterDetailState) -> CharacterDetailView {
        CharacterDetailView(viewModel: createViewModel(viewData: viewData), state: state)
    }

    // MARK: - ViewModel Factory

    /// Construye y devuelve una instancia de `CharacterDetailViewModel` con las dependencias necesarias.
    ///
    /// - Parameters:
    ///   - viewData: Contiene la información detallada del personaje y el proveedor de datos asociado.
    /// - Returns: Una instancia de `CharacterDetailViewModel`.
    private func createViewModel(viewData: CharacterDetailViewData) -> CharacterDetailViewModel {
        CharacterDetailViewModel(
            getCharactersListType: createUseCase(),
            characterDetailPresentable: viewData.detail,
            errorMapper: CharactersPresentableErrorMapper()
        )
    }

    // MARK: - UseCase Factory

    /// Construye y devuelve una instancia de `GetCharactersListType` (caso de uso) para manejar la lógica de negocio.
    ///
    /// - Returns: Una instancia de `GetCharactersListType`.
    private func createUseCase() -> GetCharactersListType {
        GetCharacters(repository: createRepository())
    }

    // MARK: - Repository Factory

    /// Construye y devuelve una instancia de `CharactersRepositoryType` (repositorio) que gestiona el acceso a los datos de los personajes.
    ///
    /// - Returns: Una instancia de `CharactersRepositoryType`.
    private func createRepository() -> CharactersRepositoryType {
        CharacterListRepository(apiDataSource: createDataSource())
    }

    // MARK: - DataSource Factory

    /// Construye y devuelve una instancia de `ApiCharacterListDataSourceType` (fuente de datos) que obtiene información del API.
    ///
    /// - Returns: Una instancia de `ApiCharacterListDataSourceType`.
    private func createDataSource() -> CharacterAPIListDataSourceType {
        CharacterAPIListDataSource(httpClient: createHTTPClient())
    }

    // MARK: - HTTP Client Factory

    /// Construye y devuelve una instancia de `HttpClient` para manejar solicitudes HTTP.
    ///
    /// - Returns: Una instancia de `HttpClient`.
    private func createHTTPClient() -> HttpClient {
        URLSessionHTTPCLient(
            requestMaker: UrlSessionRequestMaker(),
            errorResolver: URLSessionErrorResolver()
        )
    }
}
