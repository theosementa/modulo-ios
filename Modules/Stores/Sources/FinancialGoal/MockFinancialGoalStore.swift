//
//  MockFinancialGoalStore.swift
//  Stores
//
//  Created by Theo Sementa on 22/03/2026.
//

import Foundation
import Models
import Repositories

@Observable
public final class MockFinancialGoalStore: FinancialGoalStore {

    @MainActor public static let shared = MockFinancialGoalStore()

    public var repository: FinancialGoalRepository = .init()
    public var financialGoals: [FinancialGoalDomain] = FinancialGoalDomain.mocks

    public init() {}

    // MARK: - Overrides (in-memory, no SwiftData)

    public func fetchAll() {
        // No-op: données déjà chargées en mémoire
    }

    public func findOne(by id: String) -> FinancialGoalDomain? {
        financialGoals.first(where: { $0.id == id })
    }

    public func delete(by id: String) {
        financialGoals.removeAll(where: { $0.id == id })
    }

}
