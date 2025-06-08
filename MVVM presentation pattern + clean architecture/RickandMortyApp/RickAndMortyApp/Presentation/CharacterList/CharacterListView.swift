//
//  TheRickAndMortyApp.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import SwiftUI
import Foundation

struct CharacterListView: View {
    // MARK: - Environment Objects
    @EnvironmentObject private var coordinator: AppCoordinator
    @EnvironmentObject private var networkMonitor: NetworkMonitor

    // MARK: - Observed Objects
    @ObservedObject private var viewModel: CharactersViewModel

    // MARK: - States
    @State private var searchText = ""

    // MARK: - Initialization
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {
                if viewModel.showLoadingSpinner {
                    loadingView
                } else {
                    content
                        .navigationDestination(for: AppPages.self) { page in
                            coordinator.build(page: page)
                        }
                }
            }
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "text_search_characters".localized
        )
        .environment(\.locale, .init(identifier: "es"))
        .accentColor(.purple)
    }

    // MARK: - Subviews
    @ViewBuilder
    private var content: some View {
        if let errorMessage = viewModel.showErrorMessage {
            errorMessageView(errorMessage)
        } else {
            characterList
        }
    }

    private var loadingView: some View {
        HStack(spacing: 10) {
            ProgressView().progressViewStyle(.circular)
            Text(viewModel.loaderMessage)
        }
        .padding()
    }

    private var characterList: some View {
        List {
            ForEach(searchResults, id: \.id) { character in
                let viewData = CharacterDetailViewData(
                    detail: CharacterDetailPresentableItem(
                        presentableListModel: character
                    )
                )
                Button(action: {
                    coordinator.push(page: .detail(viewData: viewData))
                }) {
                    CharacterListItemView(item: character)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .navigationTitle("text_title".localized)
        .refreshable {
            viewModel.setup()
        }
    }

    private func errorMessageView(_ errorMessage: String) -> some View {
        VStack {
            Text(errorMessage)
                .font(.headline)
                .foregroundColor(.red)
                .padding()
            Button("Retry") {
                viewModel.setup()
            }
            .padding()
            .foregroundColor(.blue)
        }
    }

    private var searchResults: [CharacterListPresentableItem] {
        searchText.isEmpty ? viewModel.characters : viewModel.characters.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
}

// MARK: - Previews
struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListFactory().build()
    }
}
