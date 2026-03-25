//
//  GenericRepository.swift
//  POC_PhotoKit
//
//  Created by Theo Sementa on 13/05/2025.
//

import Foundation
import SwiftData

@MainActor
open class GenericRepository<T: PersistentModel> {
    
    public let container: ModelContainer
    public var context: ModelContext { container.mainContext }

    public init(manager: SwiftDataContextManager = .shared) {
        self.container = manager.container
    }
}

public extension GenericRepository {
    
    @discardableResult
    func save(_ entity: T) throws -> T? {
        context.insert(entity)
        try context.save()
        return try fetchOneById(entity.id)
    }
    
    func delete(_ entity: T) throws {
        context.delete(entity)
        try context.save()
    }
    
    func saveContext() throws {
        try context.save()
    }
    
    func fetchAll() throws -> [T] {
        try context.fetch(FetchDescriptor<T>())
    }
    
    func fetchOneById(_ id: PersistentIdentifier) throws -> T? {
        let predicate = #Predicate<T> { $0.persistentModelID == id }
        var fetchDescriptor = FetchDescriptor<T>(predicate: predicate)
        fetchDescriptor.fetchLimit = 1
        return try container.mainContext.fetch(fetchDescriptor).first
    }
    
}
