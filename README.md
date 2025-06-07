# RickAndMortyTCA

## Project Overview

RickAndMortyTCA is a sample iOS application built using **SwiftUI** and **The Composable Architecture (TCA)**. The goal of this project is to demonstrate a scalable, testable, and modular architecture by consuming a public **GraphQL API** (Rick and Morty API) to display a paginated list of characters and their detail views.

The architecture is strictly based on TCA principles, offering clear state management, composable features, and enhanced testability.

---

## Architecture: The Composable Architecture (TCA)

### Key Concepts

- **State**: A single source of truth for each domain (feature).
- **Action**: Enumerates all user actions and side-effect results.
- **Reducer**: Pure functions that describe how to evolve the state and effects to produce.
- **Store**: The runtime engine that drives your app by holding state and processing actions.

TCA promotes **composability**, **predictability**, and **testability** by organizing features in a predictable structure. Each screen or feature becomes a standalone and reusable module.

---

## CharacterListDomain: Feature Breakdown

`CharacterListDomain` is the central feature responsible for fetching, displaying, filtering, and paginating characters from the GraphQL API. It also manages the presentation of a character's detailed view.

### State

- `characterList`: Holds all character items loaded.
- `filteredList`: Stores the filtered results for search.
- `isLoading`, `shouldShowError`: Computed flags derived from `dataLoadingStatus`.
- `searchText`: Query used for search functionality.
- `characterDetail`: Presented detail domain when a character is tapped.
- `pagination`: Includes `currentPage`, `canLoadMorePages`, `isPaginating`.

### Actions

- `fetchCharacters`: Triggers the initial or paginated character load.
- `fetchCharactersResponse`: Handles the result of the API call.
- `setDetailView`: Opens or closes the character detail view.
- `searchTextChanged`: Updates the filter results.
- `loadNextPage`: Loads more characters when reaching the end of the list.

### Dependencies

- `fetchCharactersPaginated`: Injected API client function for paginated fetches.
- `uuid`: Generates unique identifiers for each item.

### Highlights

- Composability using `.forEach` and `.ifLet` for scoped reducers.
- Clear separation of responsibilities and side effects.
- Pagination support without mixing presentation logic into reducers.
- Live and mock dependency support for API and UUID.
- Supports presentation using `@Presents` and `.sheet` handling.

---

## Advantages of Using TCA

1. **Testability**

   TCA encourages writing isolated and deterministic unit tests. All state transitions and side effects are explicit and testable.

   Example test scenarios:
   - Load initial characters.
   - Handle pagination and append new results.
   - Filter characters using search text.
   - Trigger and dismiss detail view on tap.

2. **Modularization**

   Every feature can be extracted into an independent module, and reused across different apps or targets. This project splits:
   - `CharacterListDomain`
   - `CharacterItemDomain`
   - `CharacterDetailDomain`

3. **Predictable state management**

   There's a single entry point for modifying state: through `Store.send(Action)`. No hidden state changes.

4. **Clear lifecycle control**

   Asynchronous operations and UI presentation are managed explicitly using `Effect`, `TaskResult`, and `.presented` actions.

---

## Installation Guide

### Requirements

- Xcode 14.0 or later
- iOS 16.0+
- Swift Package Manager (SPM)
