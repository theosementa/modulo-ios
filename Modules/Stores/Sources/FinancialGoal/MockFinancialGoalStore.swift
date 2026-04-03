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

}

extension MockFinancialGoalStore {
    
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
    
}
