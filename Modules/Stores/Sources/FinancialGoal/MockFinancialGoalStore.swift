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
        financialGoals = FinancialGoalDomain.mocks
    }

    public func findOne(by id: String) -> FinancialGoalDomain? {
        financialGoals.first(where: { $0.id == id })
    }

    public func findOneDetailed(by id: String) -> FinancialGoalDetailedDomain? {
        guard let goal = financialGoals.first(where: { $0.id == id }) else { return nil }
        return FinancialGoalDetailedDomain(goal: goal, contributions: ContributionDomain.mocks(for: id))
    }
    
    public func delete(by id: String) {
        financialGoals.removeAll(where: { $0.id == id })
    }

    public func addContribution(to goalId: String, name: String?, amount: Double, type: ContributionType, date: Date) {
        guard let index = financialGoals.firstIndex(where: { $0.id == goalId }) else { return }
        let goal = financialGoals[index]
        let delta = type == .add ? amount : -amount
        financialGoals[index] = FinancialGoalDomain(
            id: goal.id,
            name: goal.name,
            emoji: goal.emoji,
            goalAmount: goal.goalAmount,
            currentAmount: goal.currentAmount + delta,
            startDate: goal.startDate,
            endDate: goal.endDate
        )
    }

}
