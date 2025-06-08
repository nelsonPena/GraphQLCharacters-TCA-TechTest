//
//  DeleteCharacters.swift
//  TheRickAndMorty
//
//  Created by Nelson Geovanny Pena Agudelo on 15/10/23.
//

import Foundation
import CoreData

extension CharactersEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharactersEntity> {
        return NSFetchRequest<CharactersEntity>(entityName: "CharactersEntity")
    }
    @NSManaged public var id: UUID
    @NSManaged public var characterId: String
    @NSManaged public var name: String
    @NSManaged public var species: String
    @NSManaged public var gender: String
    @NSManaged public var originName: String
    @NSManaged public var locationName: String
    @NSManaged public var image: String
    @NSManaged public var created: String
    @NSManaged public var status: String
}
