import Foundation
import Combine

/// `DataProvider` manages the logic related to storing and retrieving character data in the domain layer.
class DataProvider {
    
    private let formatter = DateFormatter()
    private weak var model: DataLayerRepository?
    private var cancellables = Set<AnyCancellable>()
    
    /// A published property that emits an array of `SavedCharacters` objects.
    @Published var characters: [SavedCharacters] = []
    
    /// Initializes a new instance of `DataProvider` with a custom data layer model.
    ///
    /// - Parameter model: The data layer model used to manage character data.
    init(model: DataLayerRepository) {
        formatter.dateStyle = .medium
        self.model = model
        load()
    }
    
    // MARK: - Private Methods
    
    /// Loads characters from the data layer model and assigns them to the `characters` published property.
    private func load() {
        guard let model else { return }
        
        model.$characters
            .map { characters -> [SavedCharacters] in
                characters.map { SavedCharacters(characterId: $0.characterId,
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
            .catch { error -> Just<[SavedCharacters]> in }
            .sink { [weak self] savedCharacters in
                self?.characters = savedCharacters
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Public Methods
    
    /// Deletes all characters.
    func deleteAllCharacters() {
        guard let model else { return }
        model.deleteAllCharacters()
    }
    
    /// Adds a list of characters to the data layer.
    ///
    /// - Parameter characters: The list of characters to add.
    func add(characters: [CharacterListPresentableItem]) {
        guard let model else { return }
        model.addCharacters(characters: characters)
    }
    
    /// Deletes a character by its UUID.
    ///
    /// - Parameter id: The UUID of the character to delete.
    func deleteCharacter(by id: UUID) {
        guard let model else { return }
        if let characterToDelete = model.characters.first(where: { $0.id == id }) {
            model.delete(characterToDelete)
        }
    }
}
