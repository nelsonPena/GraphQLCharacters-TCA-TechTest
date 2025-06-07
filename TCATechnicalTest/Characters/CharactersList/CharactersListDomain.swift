//
//  CharactersListDomain.swift
//  TCA Technical Test
//
//  Created by Nelson Peña Agudelo on 6/06/25.
//

import Foundation
import ComposableArchitecture


@Reducer
struct CharacterListDomain {
    
    @ObservableState
    struct State: Equatable {
        var isLoading: Bool {
            dataLoadingStatus == .loading
        }
        var shouldShowError: Bool {
            dataLoadingStatus == .error
        }
        var dataLoadingStatus = DataLoadingStatus.notStarted
        var characterList: IdentifiedArrayOf<CharacterItemDomain.State> = []
        //filter
        var searchText: String = ""
        var filteredList: IdentifiedArrayOf<CharacterItemDomain.State> = []
        //detail
        @Presents var characterDetail: CharacterDetailDomain.State?
        // pagination
        var currentPage = 1
        var canLoadMorePages = true
        var isPaginating = false
    }
    
    enum Action: Equatable {
        case fetchCharacters
        case fetchCharactersResponse(TaskResult<[Character]>)
        case setDetailView(isPresented: Bool, character: Character)
        case character(IdentifiedActionOf<CharacterItemDomain>)
        case detail(PresentationAction<CharacterDetailDomain.Action>)
        case closeCharacter
        case searchTextChanged(String)
        case loadNextPage
    }
    
    @Dependency(\.apiClient.fetchCharactersPaginated) var fetchCharactersPaginated
    @Dependency(\.uuid) var uuid
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchCharacters:
                guard state.dataLoadingStatus != .loading else {
                    return .none
                }
                state.dataLoadingStatus = .loading
                return .run { [page = state.currentPage] send in
                    await send(
                        .fetchCharactersResponse(
                            TaskResult {
                                try await fetchCharactersPaginated(page)
                            }
                        )
                    )
                }
            case let .fetchCharactersResponse(.success(characters)):
                state.isPaginating = false
                state.dataLoadingStatus = .success
                
                if characters.isEmpty {
                    state.canLoadMorePages = false
                    return .none
                }
                
                let newItems = characters.map { CharacterItemDomain.State(id: uuid(), character: $0) }
                state.characterList.append(contentsOf: newItems)
                state.filteredList.append(contentsOf: newItems)
                return .none
            case .fetchCharactersResponse(.failure(let error)):
                print("❌ fetch characters response error: \(error)")
                state.isPaginating = false
                state.dataLoadingStatus = .error
                return .none
            case .setDetailView(let isPresented, let character):
                state.characterDetail = isPresented
                ? CharacterDetailDomain.State(
                    character: CharacterDetail(from: character)
                )
                : nil
                return .none
            case let .character(.element(id: id, action: .didTap)):
                guard let item = state.characterList[id: id] else {
                    return .none
                }
                return .send(
                    .setDetailView(isPresented: true, character: item.character)
                )
            case .detail(.presented(let action)):
                switch action {
                case .didPressCloseButton:
                    return closeCharacter(state: &state)
                }
            case .detail(.dismiss):
                return .none
            case .closeCharacter:
                return closeCharacter(state: &state)
            case .searchTextChanged(let text):
                state.searchText = text
                if text.isEmpty {
                    state.filteredList = state.characterList
                } else {
                    state.filteredList = state.characterList.filter {
                        $0.character.name.localizedCaseInsensitiveContains(text)
                    }
                }
                return .none
            case .loadNextPage:
                guard !state.isPaginating, state.canLoadMorePages, state.searchText.isEmpty else { return .none }
                state.isPaginating = true
                state.currentPage += 1
                
                return .run { [page = state.currentPage] send in
                    await send(
                        .fetchCharactersResponse(
                            TaskResult {
                                try await fetchCharactersPaginated(page)
                            }
                        )
                    )
                }
            }
        }
        .forEach(\.characterList, action: \.character) {
            CharacterItemDomain()
        }
        .ifLet(\.$characterDetail, action: \.detail) {
            CharacterDetailDomain()
        }
    }
    
    private func closeCharacter(
        state: inout State
    ) -> Effect<Action> {
        state.characterDetail = nil
        return .none
    }
}
