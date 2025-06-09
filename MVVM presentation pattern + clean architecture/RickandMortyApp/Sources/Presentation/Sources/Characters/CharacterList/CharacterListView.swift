//
//  TheRickAndMortyApp.swift
//  TheRickAndMorty
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import SwiftUI
import Foundation

public struct CharacterListView: View {
    // MARK: - Observed Objects
    @ObservedObject private var viewModel: CharactersViewModel
    @ObservedObject var state: CharacterListState
    // MARK: - States
    @State private var searchText = ""
    
    // MARK: - Initialization
    public init(viewModel: CharactersViewModel, state: CharacterListState) {
        self.viewModel = viewModel
        self.state = state
    }
    
    // MARK: - Body
    public var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                loadingView
            } else {
                content
            }
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "text_search_characters".localized
        )
        .environment(\.locale, .init(identifier: "es"))
        .accentColor(.purple)
        .navigationBarBackButtonHidden(true)
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
                Button(action: {
                    let viewData = CharacterDetailViewData(
                        detail: CharacterDetailPresentableItem(
                            presentableListModel: character
                        )
                    )
                    state.selectedCharacter = viewData
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
