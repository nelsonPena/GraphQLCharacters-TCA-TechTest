//
//  CharacterListView.swift
//  TCATechnicalTest
//
//  Created by Nelson Peña Agudelo on 6/06/25.
//

import SwiftUI
import ComposableArchitecture

struct CharacterListView: View {
    
    @Bindable var store: StoreOf<CharacterListDomain>
    @State private var searchText: String = ""

    var body: some View {
        WithPerceptionTracking {
            NavigationStack {
                ZStack {
                    Color(.systemGroupedBackground)
                        .ignoresSafeArea()

                    content
                        .padding(.horizontal)
                }
                .navigationTitle("characters_title".localized)
                .navigationBarTitleDisplayMode(.large)
                .searchable(
                    text: $store.searchText.sending(\..searchTextChanged),
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "characters_search_prompt".localized
                )
                .sheet(
                    item: $store.scope(
                        state: \..characterDetail,
                        action: \..detail
                    )
                ) { store in
                    CharacterDetailView(store: store)
                }
                .task {
                    store.send(.fetchCharacters)
                }
                .tint(.accentColor)
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        if store.isLoading {
            loadingView
        } else if store.shouldShowError {
            errorMessageView()
        } else {
            characterList
        }
    }

    private var characterList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(
                    store.scope(
                        state: \..filteredList,
                        action: \..character
                    ),
                    id: \.id
                ) { cellStore in
                    WithPerceptionTracking {
                        CharacterCell(store: cellStore)
                            .onAppear {
                                if cellStore.id == store.filteredList.last?.id {
                                    store.send(.loadNextPage)
                                }
                            }
                    }
                }
            }
            .padding(.top)
        }
        .refreshable {
            store.send(.fetchCharacters)
        }
    }

    private var loadingView: some View {
        VStack(spacing: 12) {
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(1.5)
            Text("characters_loading_message".localized)
                .font(.callout)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func errorMessageView() -> some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("characters_error_message".localized)
                .font(.headline)
                .foregroundColor(.primary)
            Button(action: {
                store.send(.fetchCharacters)
            }) {
                Text("characters_retry_button".localized)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.accentColor.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CharacterListView(
        store: Store(
            initialState: CharacterListDomain.State(
                characterList: IdentifiedArray(
                    uniqueElements: Character.sample.map {
                        CharacterItemDomain.State(id: UUID(), character: $0)
                    }
                )
            ),
            reducer: {
                CharacterListDomain()
            }
        )
    )
}

