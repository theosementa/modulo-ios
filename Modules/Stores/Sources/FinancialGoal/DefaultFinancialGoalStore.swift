//
//  File.swift
//  Stores
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation
import Repositories
import Models

@Observable
public final class DefaultFinancialGoalStore: FinancialGoalStore {
    
    @MainActor public static let shared = DefaultFinancialGoalStore()
    
    public var repository: FinancialGoalRepository
    public var financialGoals: [FinancialGoalDomain] = []
    
    public init(repository: FinancialGoalRepository = .init()) {
        self.repository = repository
    }
    
}

public extension DefaultFinancialGoalStore {
    
    func fetchAll() {
        do {
            let entities = try repository.fetchAll()
            self.financialGoals = entities.map { $0.toDomain() }
        } catch {
            
        }
    }
    
    func findOneDetailed(by id: String) -> FinancialGoalDetailedDomain? {
        guard let uuid = UUID(uuidString: id) else { return nil }
        return repository.fetchOneByEntityId(uuid)?.toDetailed()
    }
    
}
