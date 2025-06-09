import Foundation
import UseCaseProtocol
import RepositoryProtocol
import Entities
import Combine

/// `DataProvider` manages the logic related to storing and retrieving character data in the domain layer.
@available(iOS 13.0, *)
public class DataProvider {
    
    private let formatter = DateFormatter()
    private weak var repository: DataProviderRepositoryType?
    private var cancellables = Set<AnyCancellable>()
    
    /// A published property that emits an array of `SavedCharacters` objects.
    @Published var characters: [SavedCharacter] = []
    
    /// Initializes a new instance of `DataProvider` with a custom data layer model.
    ///
    /// - Parameter model: The data layer model used to manage character data.
    public init(repository: DataProviderRepositoryType) {
        formatter.dateStyle = .medium
        self.repository = repository
        load()
    }
    
    // MARK: - Private Methods
    
    /// Loads characters from the data layer model and assigns them to the `characters` published property.
    private func load() {
        guard let repository else { return }
        
        repository.savedCharactersPublisher
            .map { characters -> [SavedCharacter] in
                characters.map { SavedCharacter(characterId: $0.characterId,
                                                id: $0.id,
                                                name: $0.name,
                                                species: $0.species,
                                                gender: $0.gender,
                                                originName: $0.originName,
                                                locationName: $0.locationName,
                                                image: $0.image,
                                                created: $0.created,
                                                status: $0.status) }
            }
            .catch { error -> Just<[SavedCharacter]> in }
            .sink { [weak self] savedCharacters in
                self?.characters = savedCharacters
            }
            .store(in: &cancellables)
    }
}

@available(iOS 13.0, *)
extension DataProvider: GetDataProviderType {
   
    public var savedCharactersPublisher: Published<[SavedCharacter]>.Publisher {
       $characters
    }
    
    public func addCharacters(characters: [SavedCharacter]) {
        guard let repository else { return }
        repository.addCharacters(characters: characters)
    }
    
    public func delete(_ charactersToDelete: SavedCharacter) {
        guard let repository else { return }
        repository.savedCharactersPublisher
            .first()
            .sink { characters in
                if let characterToDelete = characters.first(where: { $0.id == charactersToDelete.id }) {
                    repository.delete(characterToDelete)
                }
            }
            .store(in: &cancellables)
    }
    
    public func deleteAll() {
        guard let repository else { return }
        repository.deleteAll()
    }
}
