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
    public let context: ModelContext

    public init() {
        let manager: SwiftDataContextManager = .shared
        
        self.container = manager.container
        self.context = manager.context
    }
}

public extension GenericRepository {
    func insert(_ entity: T) throws {
        container.mainContext.insert(entity)
        try container.mainContext.save()
    }

    func delete(_ entity: T) throws {
        container.mainContext.delete(entity)
        try container.mainContext.save()
    }
    
    func fetchAll() throws -> [T] {        
        let fetchDescriptor = FetchDescriptor<T>(sortBy: [])
        let tags = try container.mainContext.fetch(fetchDescriptor)
        return tags
    }
    
    func fetchOneById(_ id: PersistentIdentifier) throws -> T {
        let predicate = #Predicate<T> { $0.persistentModelID == id }
        
        var fetchDescriptor = FetchDescriptor<T>(predicate: predicate)
        fetchDescriptor.fetchLimit = 1
        
        let results = try container.mainContext.fetch(fetchDescriptor)
        if let first = results.first {
            return first
        } else {
            throw NSError(domain: "Error fetch one by id", code: 10)
        }
    }
}
