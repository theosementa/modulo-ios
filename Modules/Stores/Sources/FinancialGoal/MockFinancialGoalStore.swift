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
    public var currentGoalId: String?

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

    public func fetchContributions(for goalId: String, offset: Int, limit: Int) -> [ContributionDomain] {
        let all = ContributionDomain.mocks(for: goalId)
        guard offset < all.count else { return [] }
        return Array(all[offset..<min(offset + limit, all.count)])
    }

    public func fetchMonthlyDataPoints(for goalId: String) -> [ContributionMonthlyDataPoint] {
        let all = ContributionDomain.mocks(for: goalId)
        let calendar = Calendar.current

        guard
            let oldestDate = all.map(\.date).min(),
            let newestDate = all.map(\.date).max(),
            let startOfFirstMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: oldestDate)),
            let startOfLastMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: newestDate))
        else { return [] }

        var result: [ContributionMonthlyDataPoint] = []
        var cursor = startOfFirstMonth

        while cursor <= startOfLastMonth {
            let monthStart = cursor
            let monthEnd = calendar.date(byAdding: .month, value: 1, to: cursor) ?? cursor

            let net = all
                .filter { $0.date >= monthStart && $0.date < monthEnd }
                .reduce(0.0) { $0 + ($1.type == .add ? $1.amount : -$1.amount) }

            result.append(ContributionMonthlyDataPoint(
                id: monthStart.formatted(.dateTime.year().month()),
                month: monthStart,
                monthLabel: monthStart.formatted(.dateTime.month(.abbreviated).year(.twoDigits)),
                netAmount: net
            ))

            cursor = monthEnd
        }

        return result
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
